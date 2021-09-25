(import-macros {: as->} :crux.lib.macro.thread)

(local {: inc
        : empty?
        : nil?
        : mapv
        : conj
        : cons
        : dissoc
        :some some?} (require :cljlib))
(local {:sumhexa md5} (require :md5))
(local {: ->str
        : str->seq
        : seq->set} (require :crux.lib.flux))
(local {: fn?} (require :crux.lib.macro.utils))
(local {: exists?} (require :crux.lib.module))
(local rex ((require :rex_pcre2)))
(local {: format} string)
(local {: concat} table)

(fn core/gensym [...]
  "Generates a new symbol to use as a global variable name.
  The symbol is generated based on the checksum (using md5) of the
  concatenation of the arguments (each one converted to string using
  `fennel.view`).
  The returned symbol follows the structure `__%s` where `%s` is the checksum."
  (->> (icollect [_ expr (ipairs [...])]
                 (->str expr))
       (concat)
       (md5)
       (format "__%s")
       (sym)))

(fn vlua [symbol]
  "Returns a symbol mapped to `v:lua.%s()` where `%s` is the symbol."
  (format "v:lua.%s()" (->str symbol)))

(fn set! [...]
  "Set one or multiple vim options using the `vim.opt` API.
  The name of the option must be a symbol.
  If the option doesn't have a value, if it begins with 'no' the value becomes
  false, and true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn set!/expr [name ?value]
    (let [name (->str name)
          value (or ?value (not (rex.match name "^no")))
          name (rex.match name "^(?:no)?(.+)$")]
      (if (fn? value)
        (let [fsym (core/gensym value)]
          `(do
             (global ,fsym ,value)
             (tset vim.opt ,name ,(vlua fsym))))
        (match (name:sub -1)
          :+ `(: (. vim.opt ,(name:sub 1 -2)) :append ,value)
          :- `(: (. vim.opt ,(name:sub 1 -2)) :remove ,value)
          :^ `(: (. vim.opt ,(name:sub 1 -2)) :prepend ,value)
          _ `(tset vim.opt ,name ,value)))))
  (fn set!/exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(set!/expr name value)
                                                      (unpack (set!/exprs (unpack rest)))]
      [name & rest] [(set!/expr name)
                     (unpack (set!/exprs (unpack rest)))]
      _ []))
  (let [exprs (set!/exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn buf-set! [...]
  "Set one or multiple vim options using the `vim.opt_local` API.
  The name of the option must be a symbol.
  If the option doesn't have a value, if it begins with 'no' the value becomes
  false, and true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn bufset!/expr [name ?value]
    (let [name (->str name)
          value (or ?value (not (rex.match name "^no")))
          name (rex.match name "^(?:no)?(\\w+)$")]
      (if (fn? value)
        (let [fsym (core/gensym value)]
          `(do
             (global ,fsym ,value)
             (tset vim.opt_local ,name ,(vlua fsym))))
        (match (name:sub -1)
          :+ `(: (. vim.opt_local ,(name:sub -1 -2)) :append ,value)
          :- `(: (. vim.opt_local ,(name:sub -1 -2)) :remove ,value)
          :^ `(: (. vim.opt_local ,(name:sub -1 -2)) :prepend ,value)
          _ `(tset vim.opt_local ,name ,value)))))
  (fn bufset!/exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(bufset!/expr name value)
                                                      (unpack (bufset!/exprs (unpack rest)))]
      [name & rest] [(bufset!/expr name)
                     (unpack (bufset!/exprs (unpack rest)))]
      _ []))
  (let [exprs (bufset!/exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn let! [...]
  "Set a vim variable using the `vim.[gbwt]` API.
  The name can be either a symbol or a string.
  If the name begins with `[gbwt]/`, `[gbwt]:` or `[gbwt].` the
  name is scoped to the respective scope:
  g -> global (default)
  b -> buffer
  w -> window
  t -> tab"
  (fn let!/expr [name value]
    (let [name (->str name)
          scope (when (some? #(= $ (name:sub 1 2)) ["g/" "b/" "w/" "t/"
                                                    "g." "b." "w." "t."
                                                    "g:" "b:" "w:" "t:"])
                  (name:sub 1 1))
          name (if (nil? scope) name (name:sub 3))]
      `(tset ,(match scope
                :b 'vim.b
                :w 'vim.w
                :t 'vim.t
                _ 'vim.g) ,name ,value)))
  (fn let!/exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name value & rest] [(let!/expr name value)
                           (unpack (let!/exprs (unpack rest)))]
      _ []))
  (let [exprs (let!/exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn augroup! [name ...]
  "Defines an autocommand group using the `vim.cmd` API."
  `(do
     ,(unpack
        (-> [`(vim.cmd ,(format "augroup %s" name))
             `(vim.cmd "autocmd!")]
            (conj ...)
            (conj `(vim.cmd "augroup END"))))))

(fn buf-augroup! [name ...]
  "Defines a buffer-local autocommand group using the `vim.cmd` API."
  `(do
     ,(unpack
        (-> [`(vim.cmd ,(format "augroup %s" name))
             `(vim.cmd "autocmd! * <buffer>")]
            (conj ...)
            (conj `(vim.cmd "augroup END"))))))

(fn autocmd! [events pattern command]
  "Defines an autocommand using the `vim.cmd` API."
  (let [events (as-> events $
                     (if (sequence? $) $ [$])
                     (mapv ->str $)
                     (table.concat $ ","))
        pattern (as-> pattern $
                      (if (sequence? $) $ [$])
                      (mapv ->str $)
                      (table.concat $ ","))]
    (if (fn? command)
      (let [fsym (core/gensym command)]
        `(do
           (global ,fsym ,command)
           (vim.cmd ,(format "autocmd %s %s call %s"
                                    events pattern (vlua fsym)))))
      `(vim.cmd ,(format "autocmd %s %s %s"
                                events pattern command)))))

(fn doc-map! [mode lhs {:buffer buffer? :silent silent?
                        :noremap noremap? :nowait nowait?} description]
  "Documents a mapping using which-key, if the plugin is available."
  `(let [(ok?# which-key#) (pcall #(require :which-key))]
     (when ok?#
       (which-key#.register
         {,lhs ,description}
         {:mode ,mode
          :buffer ,(if buffer? 0)
          :silent ,(if silent? true)
          :noremap ,(if (not noremap?) false)
          :nowait ,(if nowait? true)}))))

(fn map! [[modes & options] lhs rhs ?description]
  "Defines a vim mapping using the `vim.api.nvim_set_keymap` API or the
  `vim.api.nvim_buf_set_keymap` if the option `:buffer` was passed.
  Support all the options the API supports.
  If the `rhs` argument is a function then automatically includes the
  `:expr` option."
  (fn map!/expr [mode lhs rhs options]
    (let [buffer? (?. options :buffer)
          options (dissoc options :buffer)]
      (if buffer?
        `(vim.api.nvim_buf_set_keymap 0 ,mode ,lhs ,rhs ,options)
        `(vim.api.nvim_set_keymap ,mode ,lhs ,rhs ,options))))
  (let [modes (-> modes
                  ->str
                  str->seq)
        options (as-> options $
                      (if (fn? rhs) (conj $ :expr) $)
                      (seq->set $))
        fsym (when (fn? rhs)
               (core/gensym rhs))
        exprs (as-> modes $
                    (icollect [_ mode (ipairs $)]
                              (map!/expr mode lhs (if (fn? rhs) (vlua fsym) rhs) options))
                    (if (fn? rhs) (cons `(global ,fsym ,rhs) $) $)
                    (if (and ?description (exists? :which-key))
                      (conj $ (unpack (icollect [_ mode (ipairs mode)]
                                                (doc-map! mode lhs options ?description))))
                      $))]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(fn noremap! [[modes & options] lhs rhs ?description]
  "Defines a vim mapping using the `vim.api.nvim_set_keymap` API or the
  `vim.api.nvim_buf_set_keymap` if the option `:buffer` was passed.
  Support all the options the API supports.
  If the `rhs` argument is a function then automatically includes the `:expr`
  option.
  Automatically includes the `:noremap` option."
  (let [options (cons :noremap options)]
    (map! (cons modes options) lhs rhs ?description)))

(fn buf-map! [[modes & options] lhs rhs ?description]
  "Defines a vim mapping using the `vim.api.nvim_buf_set_keymap` if the option
  `:buffer` was passed.
  Support all the options the API supports.
  If the `rhs` argument is a function then automatically includes the `:expr`
  option."
  (let [options (cons :buffer options)]
    (map! (cons modes options) lhs rhs ?description)))

(fn buf-noremap! [[modes & options] lhs rhs ?description]
  "Defines a vim mapping using the `vim.api.nvim_buf_set_keymap` if the option
  `:buffer` was passed.
  Support all the options the API supports.
  If the `rhs` argument is a function then automatically includes the `:expr`
  option.
  Automatically includes the `:noremap` option."
  (let [options (->> options
                    (cons :buffer)
                    (cons :noremap))]
    (map! (cons modes options) lhs rhs ?description)))

(fn t [combination]
  "Returns the string with the termcodes replaced."
  `(vim.api.nvim_replace_termcodes ,(->str combination) true true true))

(fn colorscheme! [name]
  "Sets a vim colorscheme.
  The name can be either a symbol or a string."
  `(vim.cmd ,(format "colorscheme %s" (->str name))))

(fn command! [name expr]
  "Define a vim command using the `vim.cmd` API."
  (let [name (->str name)]
    (if (fn? expr)
      (let [fsym (core/gensym expr)]
        `(do
           (global ,fsym ,expr)
           (vim.cmd ,(format "command! %s call %s"
                             name (vlua fsym)))))
      `(vim.cmd ,(format "command! %s %s"
                         name expr)))))

{: set!
 : buf-set!
 : let!
 : augroup!
 : buf-augroup!
 : autocmd!
 : doc-map!
 : map!
 : noremap!
 : buf-map!
 : buf-noremap!
 : t
 : colorscheme!
 : command!}
