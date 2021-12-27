(local {: gmatch} string)
(local {: insert} table)

(local {: fn?
        : gensym-checksum
        : vlua} (require :conf.macro.helpers))

(fn ->str [x]
  (tostring x))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn tbl? [x]
  (= :table (type x)))

(lambda doc-map! [mode lhs
                  {:buffer buffer? :silent silent?
                   :noremap noremap? :nowait nowait?}
                  description]
  "Documents a keybind using which-key. If which-key is not installed it does
  nothing."
  `(let [ok?# which-key#] (pcall #(require :which-key))
     (when ok?#
       (which-key#.register {,lhs ,description}
                            {:mode ,mode
                             :buffer ,(if buffer? 0)
                             :silent ,(if silent? true)
                             :noremap ,(if (not noremap?) false)
                             :nowait ,(if nowait? true)}))))

(lambda map! [mode ?options lhs rhs]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if `:buffer` option is not set and
  `vim.api.nvim_buf_set_keymap` is `:buffer` option is set.
  If the `rhs` argument is a function then automatically sets the option
  `:expr`. This is done by detecting if `rhs` is a symbol.
  Supports all the options that the API supports."
  (assert-compile (str? mode) "expected string for mode" mode)
  (assert-compile (or (nil? ?options) (tbl? ?options)) "expected table or nil for options" ?options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs)) "expected string or symbol for rhs" rhs)
  (let [options (or (collect [k v (pairs ?options)] k v) {})
        buffer? (. options :buffer)
        options (doto options (tset :buffer nil))
        options (if (sym? rhs) (doto options (tset :expr true)) options)]
    (if buffer?
      `(vim.api.nvim_buf_set_keymap 0 ,mode ,lhs ,(if (sym? rhs) (vlua rhs) rhs) ,options)
      `(vim.api.nvim_set_keymap ,mode ,lhs ,(if (sym? rhs) (vlua rhs) rhs) ,options))))

(lambda map!-mult [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if `:buffer` option is not set and
  `vim.api.nvim_buf_set_keymap` is `:buffer` option is set.
  If the `rhs` argument is a function then automatically sets the option
  `:expr`.
  Supports all the options that the API supports."
  (assert-compile (or (str? modes) (sym? modes)) "expected string or symbol for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (fn? rhs)) "expected string or function for rhs" rhs)
  (assert-compile (or (nil? ?description) (str? ?description)) "expected string or nil for description" ?description)
  (let [modes (icollect [char (gmatch (->str modes) ".")] char)
        rhs (if (fn? rhs) `#(or (,rhs) "") rhs)
        options (collect [_ v (ipairs options)] (->str v) true)
        fsym (when (fn? rhs) (gensym-checksum "__" rhs))
        exprs (icollect [_ mode (ipairs modes)]
                        (map! mode options lhs (or fsym rhs)))
        exprs (if fsym (doto exprs (insert 1 `(global ,fsym ,rhs)))
                exprs)
        exprs (if (and ?description (pcall #(require :which-key)))
                (icollect [_ mode (ipairs modes) :into exprs]
                          (doc-map! mode lhs options ?description))
                exprs)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(lambda noremap! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if `:buffer` option is not set and
  `vim.api.nvim_buf_set_keymap` is `:buffer` option is set.
  If the `rhs` argument is a function then automatically sets the option
  `:expr`.
  Supports all the options that the API supports.
  Automatically sets the `:noremap` option."
  (let [options (doto options
                      (insert :noremap))]
    (map!-mult [modes (unpack options)] lhs rhs ?description)))

(lambda buf-map! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if `:buffer` option is not set and
  `vim.api.nvim_buf_set_keymap` is `:buffer` option is set.
  If the `rhs` argument is a function then automatically sets the option
  `:expr`.
  Supports all the options that the API supports.
  Automatically sets the `:noremap` option."
  (let [options (doto options
                      (insert :buffer))]
    (map!-mult [modes (unpack options)] lhs rhs ?description)))

(lambda buf-noremap! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if `:buffer` option is not set and
  `vim.api.nvim_buf_set_keymap` is `:buffer` option is set.
  If the `rhs` argument is a function then automatically sets the option
  `:expr`.
  Supports all the options that the API supports.
  Automatically sets the `:noremap` option."
  (let [options (doto options
                      (insert :noremap)
                      (insert :buffer))]
    (map!-mult [modes (unpack options)] lhs rhs ?description)))

{: doc-map!
 :map! map!-mult
 : noremap!
 : buf-map!
 : buf-noremap!}
