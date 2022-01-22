(fn empty? [xs]
  (= 0 (length xs)))

(fn str? [x]
  (= :string (type x)))

(fn nil? [x]
  (= nil x))

(fn ->str [x]
  (tostring x))

(fn includes? [xs x]
  (accumulate [is? false
               _ v (ipairs xs)
               :until is?] (= v x)))

(lambda let! [name value]
  "Set a vim variable using the lua API.
  The name can be either a symbol or a string.
  If the name begins with [gbwt] followed by [/:.], the name is scoped to the
  respective scope:
  g -> global (default)
  b -> buffer
  w -> window
  t -> tab"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (when (includes? ["g/" "b/" "w/" "t/"
                                "g." "b." "w." "t."
                                "g:" "b:" "w:" "t:"] (name:sub 1 2))
                (name:sub 1 1))
        name (if
               (nil? scope) name
               (name:sub 3))]
    `(tset ,(match scope
              :b 'vim.b
              :w 'vim.w
              :t 'vim.t
              _ 'vim.g) ,name ,value)))

(fn let!-mult [...]
  "Set one or multiple vim variables using the lua API.
  The name can be either a symbol or a string.
  If the name begins with [gbwt] followed by [/:.], the name is scoped to the
  respective scope:
  g -> global (default)
  b -> buffer
  w -> window
  t -> tab"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name value & rest] [(let! name value)
                           (unpack (aux (unpack rest)))]
      _ []))
  (let [exprs (aux ...)]
    (if
      (> (length exprs) 1) `(do ,(unpack exprs))
      (unpack exprs))))

{:let! let!-mult}
