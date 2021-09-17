(local {: view} (require :fennel))
(local {: conj
        : take
        : nthrest
        : concat
        : first
        : vector} (require :cljlib))

(fn ipairs#take [n seq]
  (values
    (fn [_ curr]
      (when (>= (length curr) n)
        (values (nthrest curr n) (take n curr))))
    seq seq))

(fn as-> [expr symbol ...]
  (assert-compile (sym? symbol)
                  (string.format "`%s` must be a symbol" (view symbol))
                  symbol)
  `(let [,symbol ,expr
         ,(unpack
            (accumulate [exprs (vector)
                         _ expr (ipairs [...])]
                        (conj exprs symbol expr)))]
     ,symbol))

(fn cond-> [expr ...]
  (assert-compile (= 0 (% (length [...]) 2))
                  "expected even number of cond/expr bindings"
                  ...)
  (let [symbol (gensym :symbol)]
    `(let [,symbol ,expr
           ,(unpack
              (accumulate [exprs (vector)
                           _ [cond [op & rest]] (ipairs#take 2 [...])]
                          (conj exprs symbol
                                `(if ,cond
                                   (,op ,symbol ,(unpack rest))
                                   ,symbol))))]
       ,symbol)))

(fn cond->> [expr ...]
  (assert-compile (= 0 (% (length [...]) 2))
                  "expected even number of cond/expr bindings"
                  ...)
  (let [symbol (gensym :symbol)]
    `(let [,symbol ,expr
           ,(unpack
              (accumulate [exprs (vector)
                           _ [cond expr] (ipairs#take 2 [...])]
                          (conj exprs symbol
                                `(if ,cond
                                   ,(list (unpack (conj expr symbol)))
                                   ,symbol))))]
       ,symbol)))

{: as->
 : cond->
 : cond->>}
