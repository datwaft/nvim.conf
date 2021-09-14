(local {: inc
        : nil?} (require :cljlib))
(local {: ->str} (require :core.utils.core))

(global core#id 0)
(fn core#gensym []
  "Generates a new symbol to use as a global variable name.
  The returned symbol follows the structure 'core#_n_' where `n` is the symbol
  number"
  (global core#id (inc core#id))
  (sym (string.format "core#_%s_" core#id)))

(fn vlua [symbol]
  (.. "v:lua." (->str symbol) "()"))

; (fn set! [...]
;   "Set one or multiple vim options using the `vim.opt` API.
;   The name of the option must be a symbol.
;   If the option doesn't have a value, if it begins with 'no' the value becomes
;   false, and true otherwise.
;   e.g.
;   `nospell` -> spell false
;   `spell`   -> spell true"
;   (fn set!#expr [name ?value]
;     (let [name (->str name)
;           value (or ?value (not (name:match "^no")))
;           name (if (nil? ?value) (or (name:match "^no(.*)$") name) name)])))

{: set!}
