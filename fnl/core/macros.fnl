(require :core.globals)

(global __core_symfn_id 0)
(lambda gensym-fn! []
  "Generates a new unique variable name following the structure __core_symfn_#"
  (.. "__core_symfn_"
      (do
        (global __core_symfn_id (+ __core_symfn_id 1))
        __core_symfn_id)))

(lambda get? [name]
  "Returns the value of a vim option"
  (assert-compile (or (sym? name)
                      (= "string" (type name)))
                  "'name' must be either a symbol or a string" name)
  (let [name (tostring name)
        name (if (= (name:sub 1 2) "no") (name:sub 3) name)]
    `(let [(ok?# value#) (pcall #(: (. vim.opt ,name) :get))]
       (if ok?# value# nil))))

(lambda get-local? [name]
  "Returns the value of a vim local option"
  (assert-compile (or (sym? name)
                      (= "string" (type name)))
                  "'name' must be either a symbol or a string" name)
  (let [name (tostring name)
        name (if (= (name:sub 1 2) "no") (name:sub 3) name)]
    `(let [(ok?# value#) (pcall #(: (. vim.opt_local ,name) :get))]
       (if ok?# value# nil))))

(lambda set! [name ?value]
  "Set a vim option using the vim.opt api"
  (assert-compile (or (sym? name)
                      (= "string" (type name)))
                  "'name' must be either a symbol or a string" name)
  (let [name (tostring name)
        value-is-nil? (= nil ?value)
        name-begins-with-no? (= (name:sub 1 2) "no")
        name (if (and value-is-nil? name-begins-with-no?)
               (name:sub 3)
               name)
        value (if value-is-nil?
                (not name-begins-with-no?)
                ?value)
        name-last-character (name:sub -1)
        name-without-last-character (name:sub 1 -2)]
    (if (and 
          (list? value)
          (or
            (= (tostring (. value 1)) :hashfn)
            (= (tostring (. value 1)) :fn)))
      (let [symbol (gensym-fn!)]
        `(do
           (global ,(sym symbol) ,value)
           (tset vim.opt ,name ,(string.format "v:lua.%s()" symbol))))
      (match name-last-character
        "?" `(get? ,name-without-last-character)
        "!" `(tset vim.opt ,name-without-last-character
                   (not (get? ,name-without-last-character)))
        "+" `(: (. vim.opt ,name-without-last-character) :append ,value)
        "-" `(: (. vim.opt ,name-without-last-character) :remove ,value)
        "^" `(: (. vim.opt ,name-without-last-character) :prepend ,value)
        _ `(tset vim.opt ,name ,value)))))

(lambda set-local! [name ?value]
  "Set a local vim option using the vim.opt_local api"
  (assert-compile (or (sym? name)
                      (= "string" (type name)))
                  "'name' must be either a symbol or a string" name)
  (let [name (tostring name)
        value-is-nil? (= nil ?value)
        name-begins-with-no? (= (name:sub 1 2) "no")
        name (if (and value-is-nil? name-begins-with-no?)
               (name:sub 3)
               name)
        value (if value-is-nil?
                (not name-begins-with-no?)
                ?value)
        name-last-character (name:sub -1)
        name-without-last-character (name:sub 1 -2)]
    (if (and 
          (list? value)
          (or
            (= (tostring (. value 1)) :hashfn)
            (= (tostring (. value 1)) :fn)))
      (let [symbol (gensym-fn!)]
        `(do
           (global ,(sym symbol) ,value)
           (tset vim.opt_local ,name ,(string.format "v:lua.%s()" symbol))))
      (match name-last-character
        "?" `(get-local? ,name-without-last-character)
        "!" `(tset vim.opt_local ,name-without-last-character
                   (not (get-local? ,name-without-last-character)))
        "+" `(: (. vim.opt_local ,name-without-last-character) :append ,value)
        "-" `(: (. vim.opt_local ,name-without-last-character) :remove ,value)
        "^" `(: (. vim.opt_local ,name-without-last-character) :prepend ,value)
        _ `(tset vim.opt_local ,name ,value)))))

(lambda let! [name value]
  "Set vim variable using the vim.[g b w t] api"
  (assert-compile (or (sym? name)
                      (= "string" (type name)))
                  "'name' must be either a symbol or a string" name)
  (let [name (tostring name)
        scope (if (> (length (icollect [_ v (ipairs ["g/" "b/" "w/" "t/"])]
                               (when (= (name:sub 1 2) v) v))) 0)
                (name:sub 1 1)
                nil)
        name (if (= nil scope) name (name:sub 3))]
    (match scope
      "g" `(tset vim.g ,name ,value)
      "b" `(tset vim.b ,name ,value)
      "w" `(tset vim.w ,name ,value)
      "t" `(tset vim.t ,name ,value)
      _ `(tset vim.g ,name ,value))))

(lambda augroup! [name ...]
  "Defines an augroup with a name and auto-commands"
  (assert-compile (or (sym? name)
                      (= "string" (type name)))
                  "'name' must be either a symbol or a string" name)
  `(do
     (vim.cmd ,(string.format "augroup %s\nautocmd!"
                              (tostring name)))
     (do
       ,...)
     (vim.cmd "augroup END")
     nil))

(lambda autocmd! [events pattern command]
  "Defines an auto-command"
  (let [events (table.concat (icollect [_ v (ipairs (if
                                                      (sequence? events) events
                                                      [events]))]
                               (tostring v)) ",")
        pattern (table.concat (icollect [_ v (ipairs (if
                                                       (sequence? pattern) pattern
                                                       [pattern]))]
                                (tostring v)) ",")]
    (if (not (list? command))
      `(vim.cmd ,(string.format "autocmd %s %s %s"
                                events pattern command))
      (let [name (gensym-fn!)]
        `(do
           (global ,(sym name) ,command)
           (vim.cmd ,(string.format "autocmd %s %s call v:lua.%s()"
                                    events pattern name)))))))

(lambda map! [mode-list combination command ...]
  "Maps a combination to a command in some modes"
  (let [mode-list (tostring (if (sequence? mode-list) (. mode-list 1) mode-list))
        combination (tostring combination)
        options (collect [_ option (ipairs [...])]
                  (values (tostring option) true))
        out []]
    (if (and
          (list? command)
          (or
            (= (tostring (. command 1)) :hashfn)
            (= (tostring (. command 1)) :fn)))
      (let [name (gensym-fn!)]
        (table.insert out `(global ,(sym name) ,command))
        (each [mode (string.gmatch mode-list ".")]
          (table.insert out `(vim.api.nvim_set_keymap ,mode ,combination ,(string.format "v:lua.%s()" name) ,options))))
      (each [mode (string.gmatch mode-list ".")]
        (table.insert out `(vim.api.nvim_set_keymap ,mode ,combination ,(tostring command) ,options))))
    (if (> (length out) 1)
      `(do ,(unpack out))
      `,(unpack out))))

(lambda noremap! [mode-list combination command ...]
  "Maps a combination to a command in some modes with the noremap option"
  `(map! ,mode-list ,combination ,command :noremap ,...))

(lambda t [combination]
  "Returns the string with termcodes replaced"
  (assert-compile (or (sym? combination)
                      (= "string" (type combination)))
                  "'combination' must be either a symbol or a string" combination)
  `(vim.api.nvim_replace_termcodes ,(tostring combination) true true true))

{: gensym-fn!
 : get?
 : get-local?
 : set!
 : set-local!
 : let!
 : augroup!
 : autocmd!
 : map!
 : noremap!
 : t}

;; These macros were inspired by https://github.com/tsbohc/zest.nvim.
;; In the documentation folder of this repo you can read an explanation about
;; how they work, but, if you want some macros that are plug-and-play you can
;; use zest, they are less opinionated than mine.
