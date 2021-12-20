(local {: fn?
        : gensym-checksum
        : vlua} (require :conf.macro.helpers))

(fn empty? [xs]
  (= 0 (length xs)))

(fn ->str [x]
  (tostring x))

(lambda set! [name ?value]
  "Set a vim option using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (or ?value
                  (not (name:match "^no")))
        name (or (name:match "^no(.+)$")
                 name)]
    (if (fn? value)
      (let [fsym (gensym-checksum "__" value)]
        `(do
           (global ,fsym ,value)
           (tset vim.opt ,name ,(vlua fsym))))
      (match (name:sub -1)
        :+ `(: (. vim.opt ,(name:sub 1 -2)) :append ,value)
        :- `(: (. vim.opt ,(name:sub 1 -2)) :remove ,value)
        :^ `(: (. vim.opt ,(name:sub 1 -2)) :prepend ,value)
        _ `(tset vim.opt ,name ,value)))))

(fn set!-mult [...]
  "Set one or multiple vim options using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(set! name value)
                                                      (unpack (aux (unpack rest)))]
      [name & rest] [(set! name)
                     (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs))))

(lambda local-set! [name ?value]
  "Set a vim local option using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (or ?value
                  (not (name:match "^no")))
        name (or (name:match "^no(.+)$")
                 name)]
    (if (fn? value)
      (let [fsym (gensym-checksum "__" value)]
        `(do
           (global ,fsym ,value)
           (tset vim.opt_local ,name ,(vlua fsym))))
      (match (name:sub -1)
        :+ `(: (. vim.opt_local ,(name:sub 1 -2)) :append ,value)
        :- `(: (. vim.opt_local ,(name:sub 1 -2)) :remove ,value)
        :^ `(: (. vim.opt_local ,(name:sub 1 -2)) :prepend ,value)
        _ `(tset vim.opt_local ,name ,value)))))

(fn local-set!-mult [...]
  "Set one or multiple vim local options using the lua API.
  The name of the option must be a symbol.
  If no value is specified, if the name begins with 'no' the value becomes
  false, it becomes true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(local-set! name value)
                                                      (unpack (aux (unpack rest)))]
      [name & rest] [(local-set! name)
                     (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs))))

{:set! set!-mult
 :local-set! local-set!-mult}
