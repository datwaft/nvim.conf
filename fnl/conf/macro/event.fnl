(local {: fn?} (require :conf.macro.helpers))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn tbl? [x]
  (= :table (type x)))

(fn ->str [x]
  (tostring x))

(fn first [xs]
  (. xs 1))

(fn empty? [xs]
  (= 0 (length xs)))

(lambda autocmd-group! [?group events pattern ...]
  "Defines an autocommand using the Lua API."
  (match [...]
    (where [options command ?desc] (tbl? options))
    (do
      (assert-compile (or (str? ?group) (sym? ?group) (nil? ?group)) "expected string or symbol or nil for group" ?group)
      (assert-compile (or (tbl? events) (str? events) (sym? events)) "expected table or string or symbol for events" events)
      (assert-compile (or (tbl? pattern) (str? pattern) (sym? pattern)) "expected table or string or symbol for pattern" pattern)
      (assert-compile (tbl? options) "expected table for options" options)
      (assert-compile (or (str? command) (list? command) (fn? command) (sym? command)) "expected string or list or function or symbol for command" command)
      (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
      (let [events (if (and (tbl? events) (not (sym? events)))
                     (icollect [_ v (ipairs events)] (->str v))
                     (->str events))
            pattern (if (and (tbl? pattern) (not (sym? pattern)))
                      (icollect [_ v (ipairs pattern)] (->str v))
                      (->str pattern))
            options (collect [_ v (ipairs options)] (->str v) true)
            options (if (= "<buffer>" pattern)
                      (doto options (tset :buffer 0))
                      options)
            command (if (and (not (fn? command)) (list? command)) `#,command
                      command)
            desc (if (and (not ?desc) (or (fn? command) (sym? command))) (view command)
                   ?desc)
            options (if desc (doto options (tset :desc desc))
                      options)
            options (if options.buffer
                      options
                      (doto options (tset :pattern pattern)))
            options (if ?group
                      (doto options (tset :group ?group))
                      options)
            options (if (str? command)
                      (doto options (tset :command command))
                      (doto options (tset :callback command)))]
        `(vim.api.nvim_create_autocmd ,events ,options)))
    [command ?desc] (autocmd-group! ?group events pattern [] command ?desc)))

(lambda autocmd! [...]
  "Defines an autocommand using the Lua API."
  (autocmd-group! nil ...))

(lambda augroup! [name ...]
  "Defines an autocommand group using the Lua API."
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (let [name (->str name)]
    (if (empty? [...])
      `(vim.api.nvim_create_augroup ,name {})
      (let [statements (icollect [_ statement (ipairs [...])]
                         (do
                           (assert-compile (list? statement) "expected list for statement")
                           (let [[_ events pattern options command ?desc] statement]
                             (autocmd-group! name events pattern options command ?desc))))]
        `(do
           (vim.api.nvim_create_augroup ,name {})
           ,(unpack statements))))))

{: augroup!
 : autocmd!}
