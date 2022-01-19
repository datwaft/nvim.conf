(fn table? [o]
  (= :table (type o)))

(fn deep-copy [o]
  (if (table? o)
    (collect [k v (pairs o)]
             (values (deep-copy k) (deep-copy v)))
    o))

(fn deep-merge [o1 o2]
  (match [o1 o2]
    [nil nil] nil
    [nil _] (deep-copy o2)
    [_ nil] (deep-copy o1)
    (where _ (or (not (table? o1))
                 (not (table? o2)))) (deep-copy o1)
    _ (accumulate [acc (deep-copy o2)
                   k v (pairs o1)]
                  (doto acc
                        (tset k (deep-merge v (?. acc k)))))))

{: deep-copy
 : deep-merge}
