(local {: gmatch} string)
(local {: insert} table)

(local {: fn?} (require :conf.macro.helpers))

(fn ->str [x]
  (tostring x))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn tbl? [x]
  (= :table (type x)))

(lambda map! [[modes & options] lhs rhs ?desc]
  "Defines a new mapping using the lua API.
  Supports all the options that the API supports."
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (list? rhs) (fn? rhs) (sym? rhs)) "expected string or list or function or symbol for rhs" rhs)
  (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
  (let [modes (icollect [char (gmatch (->str modes) ".")] char)
        options (collect [_ v (ipairs options)] (->str v) true)
        rhs (if (and (not (fn? rhs)) (list? rhs)) `#,rhs
              rhs)
        desc (if (and (not ?desc) (or (fn? rhs) (sym? rhs))) (view rhs)
               ?desc)
        options (if desc (doto options (tset :desc desc))
                  options)]
    `(vim.keymap.set ,modes ,lhs ,rhs ,options)))

(lambda buf-map! [[modes & options] lhs rhs ?description]
  "Defines a new mapping using the lua API.
  Supports all the options that the API supports.
  Automatically sets the `:buffer` option."
  (let [options (doto options
                      (insert :buffer))]
    (map! [modes (unpack options)] lhs rhs ?description)))

{: map!
 : buf-map!}
