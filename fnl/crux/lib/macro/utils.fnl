(local {: first} (require :cljlib))

(fn fn? [o]
  "Returns if the object is a function"
  (and
    (list? o)
    (or
      (= 'hashfn (first o))
      (= 'fn (first o)))))

{: fn?}
