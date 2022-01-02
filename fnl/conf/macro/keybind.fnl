(local {: gmatch} string)
(local {: insert} table)

(local {: fn?} (require :conf.macro.helpers))

(fn ->str [x]
  (tostring x))

(fn ->bool [x]
  (if x true false))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn tbl? [x]
  (= :table (type x)))

(fn bool? [x]
  (= :boolean (type x)))

(lambda map! [buffer? mode options lhs rhs]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if buffer? is true and
  `vim.api.nvim_buf_set_keymap` if buffer? is false.
  If rhs is a function, a symbol or a list the expr option is set.
  Supports all the options that the API supports."
  (assert-compile (bool? buffer?) "expected boolean for buffer?" buffer?)
  (assert-compile (str? mode) "expected string for mode" mode)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (str? rhs) "expected string for rhs" rhs)
  (if buffer?
    `(vim.api.nvim_buf_set_keymap 0 ,mode ,lhs ,rhs ,options)
    `(vim.api.nvim_set_keymap ,mode ,lhs ,rhs ,options)))

(lambda map!-mult [[modes & options] lhs rhs ?desc]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if buffer? is true and
  `vim.api.nvim_buf_set_keymap` if buffer? is false.
  If rhs is a function, a symbol or a list the expr option is set.
  Supports all the options that the API supports."
  (assert-compile (or (str? modes) (sym? modes)) "expected string or symbol for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (list? rhs) (fn? rhs) (sym? rhs)) "expected string or list or function or symbol for rhs" rhs)
  (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
  (let [modes (icollect [char (gmatch (->str modes) ".")] char)
        options (collect [_ v (ipairs options)] (->str v) true)
        buffer? (->bool (. options :buffer))
        options (doto options (tset :buffer nil))
        rhs (if (and (not (fn? rhs)) (list? rhs)) `#,rhs
              rhs)
        desc (if (and (not ?desc) (or (fn? rhs) (sym? rhs))) (view rhs)
               ?desc)
        options (if desc (doto options (tset :desc desc))
                  options)
        options (if (or (fn? rhs) (sym? rhs)) (doto options (tset :callback rhs))
                  options)
        options (if (or (fn? rhs) (sym? rhs)) (doto options (tset :expr true))
                  options)
        rhs (if (or (fn? rhs) (sym? rhs)) ""
              rhs)
        exprs (icollect [_ mode (ipairs modes)]
                        (map! buffer? mode options lhs rhs ?desc))]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

(lambda noremap! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if buffer? is true and
  `vim.api.nvim_buf_set_keymap` if buffer? is false.
  If rhs is a function, a symbol or a list the expr option is set.
  Supports all the options that the API supports.
  Automatically sets the `:noremap` option."
  (let [options (doto options
                      (insert :noremap))]
    (map!-mult [modes (unpack options)] lhs rhs ?description)))

(lambda buf-map! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if buffer? is true and
  `vim.api.nvim_buf_set_keymap` if buffer? is false.
  If rhs is a function, a symbol or a list the expr option is set.
  Supports all the options that the API supports.
  Automatically sets the `:buffer` option."
  (let [options (doto options
                      (insert :buffer))]
    (map!-mult [modes (unpack options)] lhs rhs ?description)))

(lambda buf-noremap! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  It uses `vim.api.nvim_set_keymap` if buffer? is true and
  `vim.api.nvim_buf_set_keymap` if buffer? is false.
  If rhs is a function, a symbol or a list the expr option is set.
  Supports all the options that the API supports.
  Automatically sets the `:noremap` option and the `:buffer` option."
  (let [options (doto options
                      (insert :noremap)
                      (insert :buffer))]
    (map!-mult [modes (unpack options)] lhs rhs ?description)))

{:map! map!-mult
 : noremap!
 : buf-map!
 : buf-noremap!}
