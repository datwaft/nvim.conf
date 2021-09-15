(local {: inc
        : empty?
        : nil?} (require :cljlib))
(local {: ->str} (require :core.utils.core))
(local {: fn?} (require :core.macro.utils))
(local rex ((require :rex_pcre2)))

(global core#id 0)
(fn core#gensym []
  "Generates a new symbol to use as a global variable name.
  The returned symbol follows the structure 'core#_%d_' where `%d` is the symbol
  number"
  (global core#id (inc core#id))
  (sym (string.format "core#_%d_" core#id)))

(fn vlua [symbol]
  (.. "v:lua." (->str symbol) "()"))

(fn set! [...]
  "Set one or multiple vim options using the `vim.opt` API.
  The name of the option must be a symbol.
  If the option doesn't have a value, if it begins with 'no' the value becomes
  false, and true otherwise.
  e.g.
  `nospell` -> spell false
  `spell`   -> spell true"
  (fn set!#expr [name ?value]
    (let [name (->str name)
          value (or ?value (not (rex.match name "^no")))
          name (rex.match name "^(?:no)?(\\w+)$")]
      (if (fn? value)
        (let [fsym (core#gensym)]
          `(do
             (global ,fsym ,value)
             (tset vim.opt ,name ,(vlua fsym))))
        (match (name:sub -1)
          :+ `(: (. vim.opt ,(name:sub -1 -2)) :append ,value)
          :- `(: (. vim.opt ,(name:sub -1 -2)) :remove ,value)
          :^ `(: (. vim.opt ,(name:sub -1 -2)) :prepend ,value)
          _ `(tset vim.opt ,name ,value)))))
  (fn set!#exprs [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value))) [(set!#expr name value)
                                                      (unpack (set!#exprs (unpack rest)))]
      [name & rest] [(set!#expr name)
                     (unpack (set!#exprs (unpack rest)))]
      _ []))
  (let [exprs (set!#exprs ...)]
    (if (> (length exprs) 1)
      `(do ,(unpack exprs))
      (unpack exprs))))

{: set!}
