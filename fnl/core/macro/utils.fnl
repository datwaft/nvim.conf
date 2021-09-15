(local {: first} (require :cljlib))

(fn fn? [obj]
  "Returns whether the object is a function"
  (and
    (list? obj)
    (or
      (= 'hashfn (first obj))
      (= 'fn (first obj)))))

{: fn?}
