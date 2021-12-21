(local {: fn?
        : gensym-checksum
        : vlua} (require :conf.macro.helpers))

(local {: format} string)

(fn empty? [xs]
  (= 0 (length xs)))

(fn str? [x]
  (= :string (type x)))

(fn ->str [x]
  (tostring x))

(lambda command! [name expr]
  "Define a user command using the vim API."
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)]
    (if (fn? expr)
      (let [fsym (gensym-checksum "__" expr)]
        `(do
           (global ,fsym ,expr)
           (vim.cmd ,(format "command! %s call %s"
                             name (vlua fsym)))))
      `(vim.cmd ,(format "command! %s %s"
                         name expr)))))

(fn command!-mult [...]
  "Define one or multiple user commands using the vim API."
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name expr & rest] [(command! name expr)
                          (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs))))

{:command! command!-mult}
