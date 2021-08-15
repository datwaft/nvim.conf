;;; Helper Functions Declaration

(fn inc [number]
  "Increments a number by 1"
  (+ number 1))

(fn dec [number]
  "Decrements a number by 1"
  (- number 1))

(fn first [seq]
  "Returns the first value of the sequence"
  (?. seq 1))

(fn last [seq]
  "Returns the last value of the sequence"
  (?. seq (length seq)))

(fn rest [seq]
  "Returns all but the first value of the sequence"
  (let [[_ & rest] seq] rest))

(fn map [fun seq]
  "Map a function over a sequence"
  (icollect [_ value (ipairs seq)]
    (fun value)))

(fn filter [cond seq]
  "Returns a sequence of every item that fulfills the condition"
  (icollect [_ value (ipairs seq)]
    (when (cond value) value)))

(fn any? [cond seq]
  "Returns true if any element of the sequence fulfills the condition"
  (accumulate [does? false
               _ value (ipairs seq)
               :until does?]
              (cond value)))

(fn every? [cond seq]
  "Returns true if every element of the sequence fulfills the condition"
  (not (accumulate [does-not? false
                    _ value (ipairs seq)
                    :until does-not?]
                   (not (cond value)))))

(fn keys [tbl]
  "Returns a sequence of all keys of a table"
  (icollect [key _ (pairs tbl)] key))

(fn vals [tbl]
  "Returns a sequence of all values of a table"
  (icollect [_ value (pairs tbl)] value))

(fn tbl->seq [tbl]
  "Converts a table into a sequence of key-value pairs"
  (icollect [key value (pairs tbl)] [key value]))

(fn str->seq [str]
  "Converts a string to a sequence of characters"
  (icollect [chr (string.gmatch str ".")] chr))

(fn ->str [obj]
  "Converts an object to its string representation"
  (tostring obj))

(fn seq->set [seq]
  "Returns a set following the structure of `{:key true}` from a sequence"
  (collect [_ value (ipairs seq)]
    (values value true)))

(fn string? [obj]
  "Returns true if the object is a string"
  (= :string (type obj)))

(fn fn? [obj]
  "Returns true if the object is a function
  This only works at compilation time"
  (and
    (list? obj)
    (or
      (= (->str (first obj)) :hashfn)
      (= (->str (first obj)) :fn))))

(fn number? [obj]
  "Returns true if the object is a number"
  (= :number (type obj)))

(fn tbl? [obj]
  "Returns true if the object is a table"
  (= :table (type obj)))

(fn seq? [obj]
  "Returns true if the object is a sequence"
  (and (tbl? obj)
       (every? number? (keys obj))))

(fn set? [obj]
  "Returns true if the object is a sequence"
  (and (tbl? obj)
       (every? #(= $ true) (vals obj))))

(fn nil? [obj]
  "Returns true if the object is nil"
  (= nil obj))

(fn contains? [seq obj]
  "Returns true if the sequence contains the object"
  (accumulate [does? false
               _ it (ipairs seq)
               :until does?]
              (= it obj)))

(fn cons [obj seq]
  "Returns a sequence with the object appended as the first element of the sequence"
  [obj (unpack seq)])

(fn conj [tbl ...]
  "Return a table or a sequence with the values/key-value pairs inserted (at the end)"
  (if (seq? tbl)
    (let [copy (icollect [v (ipairs tbl)] v)]
      (each [_ v (ipairs [...])]
        (table.insert copy v))
      copy)
    (let [copy (collect [k v (pairs tbl)] (values k v))]
      (each [_ [k v] (ipairs [...])]
        (tset copy k v))
      copy)))

(fn disj [tbl ...]
  "Return a table without the keys in the parameters"
  (let [copy (collect [k v (pairs tbl)] (values k v))]
    (each [_ key (ipairs [...])]
      (tset copy key nil))
    copy))

(fn any= [obj ...]
  "Returns true if the object equals any other parameter"
  (contains? [...] obj))

(fn exists? [module-name]
  "Returns true if the module exists and false if it doesn't"
  (let [(ok? _) (pcall require module-name)]
    ok?))

(global __core_symfn_id 0)
(fn gensym-fn! []
  "Generates a new unique variable name following the structure `__core_symfn_#`"
  (.. "__core_symfn_"
      (do
        (global __core_symfn_id (inc __core_symfn_id))
        __core_symfn_id)))

;;; Macros Declaration

(fn unless [condition ...]
  "Takes a single condition and evaluates the rest as a body if it's nil or
  false. This is intended for side-effects."
  `(when (not ,condition)
     ,...))

(fn set! [name ?value]
  "Set a vim option using the `vim.opt` API"
  (let [name (->str name)
        value (if (nil? ?value) (not (name:match "^no")) ?value)
        name (if (nil? ?value) (or (name:match "^no(.*)$") name) name)]
    (if (fn? value)
      (let [fn-name (gensym-fn!)]
        `(do
           (global ,(sym fn-name) ,value)
           (tset vim.opt ,name ,(string.format "v:lua.%s()" fn-name))))
      (match (name:sub -1)
        :+ `(: (. vim.opt ,(name:sub 1 -2)) :append ,value)
        :- `(: (. vim.opt ,(name:sub 1 -2)) :remove ,value)
        :^ `(: (. vim.opt ,(name:sub 1 -2)) :prepend ,value)
        _ `(tset vim.opt ,name ,value)))))

(fn set-local! [name ?value]
  "Set a local vim option using the `vim.opt_local` API"
  (let [name (->str name)
        value (if (nil? ?value) (not (name:match "^no")) ?value)
        name (if (nil? ?value) (or (name:match "^no(.*)$") name) name)]
    (if (fn? value)
      (let [fn-name (gensym-fn!)]
        `(do
           (global ,(sym fn-name) ,value)
           (tset vim.opt_local ,name ,(string.format "v:lua.%s()" fn-name))))
      (match (name:sub -1)
        :+ `(: (. vim.opt_local ,(name:sub 1 -2)) :append ,value)
        :- `(: (. vim.opt_local ,(name:sub 1 -2)) :remove ,value)
        :^ `(: (. vim.opt_local ,(name:sub 1 -2)) :prepend ,value)
        _ `(tset vim.opt_local ,name ,value)))))

(fn let! [name value]
  "Set a vim variable using the vim.[g b w t] API"
  (let [name (->str name)
        scope (when (any= (name:sub 1 2) "g/" "b/" "w/" "t/")
                (name:sub 1 1))
        name (if (nil? scope) name (name:sub 3))]
    (match scope
      :g `(tset vim.g ,name ,value)
      :b `(tset vim.b ,name ,value)
      :w `(tset vim.w ,name ,value)
      :t `(tset vim.t ,name ,value)
      _ `(tset vim.g ,name ,value))))

(fn augroup! [name ...]
  `(do
     (vim.cmd ,(string.format "augroup %s\nautocmd!"
                              (->str name)))
     (do
       ,...)
     (vim.cmd "augroup END")
     nil))

(fn autocmd! [events pattern command]
  "Defines an autocommand"
  (let [events (if (sequence? events) events [events])
        events (-> (map ->str events) 
                   (table.concat ","))
        pattern (if (sequence? pattern) pattern [pattern])
        pattern (-> (map ->str pattern)
                    (table.concat ","))]
    (if (fn? command)
      (let [fn-name (gensym-fn!)]
        `(do
           (global ,(sym fn-name) ,command)
           (vim.cmd ,(string.format "autocmd %s %s call v:lua.%s()"
                                    events pattern fn-name))))
      `(vim.cmd ,(string.format "autocmd %s %s call %s"
                                events pattern command)))))

(fn map! [[modes & options] lhs rhs]
  "Defines a vim mapping
  Allows functions as right-hand side"
  (fn expr [buffer? mode lhs rhs options]
    (if buffer?
      `(vim.api.nvim_buf_set_keymap 0 ,mode ,lhs ,rhs ,options)
      `(vim.api.nvim_set_keymap ,mode ,lhs ,rhs ,options)))
  (let [modes (str->seq (->str modes))
        buffer? (contains? options :buffer)
        options (-> (seq->set options)
                    (disj :buffer))]
    (if (fn? rhs)
      (let [fn-name (gensym-fn!)
            options (conj options [:expr true])
            exprs (->> (map #(expr buffer? $ lhs
                                   (string.format "v:lua.%s()" fn-name)
                                   options) modes)
                       (cons `(global ,(sym fn-name) ,rhs)))]
        `(do ,(unpack exprs)))
      (let [exprs (map #(expr buffer? $ lhs rhs options) modes)]
        (if (> (length exprs) 1)
          `(do ,(unpack exprs))
          (unpack exprs))))))

(fn noremap! [[modes & options] lhs rhs ?name]
  "Defines a vim mapping
  Allows functions as right-hand side
  Appends :noremap to the options"
  (let [options (cons :noremap options)]
    `(map! ,(cons modes options) ,lhs ,rhs ,?name)))

(fn t [combination]
  "Returns the string with termcodes replaced"
  `(vim.api.nvim_replace_termcodes ,(->str combination) true true true))

(fn has? [property]
  "Returns true if vim has a propety"
  `(match (vim.fn.has ,property)
     1 true
     0 false
     _# nil))

{: set!
 : set-local!
 : let!
 : augroup!
 : autocmd!
 : map!
 : noremap!
 : t
 : has?
 : unless}

;; These macros were inspired by https://github.com/tsbohc/zest.nvim.
;; In the documentation folder of this repo you can read an explanation about
;; how they work, but, if you want some macros that are plug-and-play you can
;; use zest, they are less opinionated than mine.
