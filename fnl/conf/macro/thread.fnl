(local {: insert} table)

(lambda as-> [[binding expr] ...]
  "A threading macro where the first argument is the value binded to the
  second argument, which must be a symbol.
  This binding is valid for the whole body of the threading macro."
  (assert-compile (sym? binding) "expected symbol for binding" binding)
  `(let [,binding ,expr
         ,(unpack
            (accumulate [exprs []
                         _ expr (ipairs [...])]
                        (doto exprs
                              (insert binding)
                              (insert expr))))]
     ,binding))

{: as->}
