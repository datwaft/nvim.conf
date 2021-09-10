(local {: inc} (require :lib.cljlib))

(global core#id 0)
(fn core#gensym []
  "Generates a new symbol to use as a global variable name.
  The returned symbol follows the structure 'core#_n_' where `n` is the symbol
  number"
  (global core#id (inc core#id))
  (sym (string.format "core#_%s_" core#id)))

{}
