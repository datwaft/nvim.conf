(local {: view} (require :fennel))
(local {: conj
        : nthrest
        : take
        : vector} (require :cljlib))

(fn itake [n xs]
  "Iterates over a collection extracting `n` element each time, no more, no
  less."
  (values
    (fn [_ curr]
      (when (>= (length curr) n)
        (values (nthrest curr n) (take n curr))))
    xs xs))

(fn as-> [expr binding ...]
  "A threading macro were the first argument is the value binded to the second
  argument, which must be a symbol.
  This binding is valid for the whole body of the threading macro."
  (assert-compile (sym? binding)
                  (string.format "`%s` must be a symbol" (view binding))
                  binding)
  `(let [,binding ,expr
         ,(unpack
            (accumulate [exprs (vector)
                         _ expr (ipairs [...])]
                        (conj exprs binding expr)))]
     ,binding))

(fn cond-> [expr ...]
  "A threading macro were the result of each expression is injected into the
  next expression as the first argument.
  If the condition before the expression is true the expression is executed, if
  not, it's ignored"
  (assert-compile (= 0 (% (length [...]) 2))
                  "expected even number of cond/expr bindings"
                  ...)
  (let [binding (gensym :binding)]
    `(let [,binding ,expr
           ,(unpack
              (accumulate [exprs (vector)
                           _ [cond [op & rest]] (itake 2 [...])]
                          (conj exprs binding
                                `(if ,cond
                                   (,op ,binding ,(unpack rest))
                                   ,binding))))]
       ,binding)))

(fn cond->> [expr ...]
  "A threading macro were the result of each expression is injected into the
  next expression as the last argument.
  If the condition before the expression is true the expression is executed, if
  not, it's ignored"
  (assert-compile (= 0 (% (length [...]) 2))
                  "expected even number of cond/expr bindings"
                  ...)
  (let [binding (gensym :binding)]
    `(let [,binding ,expr
           ,(unpack
              (accumulate [exprs (vector)
                           _ [cond expr] (itake 2 [...])]
                          (conj exprs binding
                                `(if ,cond
                                   ,(list (unpack (conj expr binding)))
                                   ,binding))))]
       ,binding)))

{: as->
 : cond->
 : cond->>}
