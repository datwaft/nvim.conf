(local {: setup} (require :indent_blankline))

(setup {:char "│"
        :filetype_exclude [:terminal :help :packer :NvimTree :fennel :clojure
                           :lisp :markdown :text :corpus]
        :buftype_exclude [:terminal :nofile]})
