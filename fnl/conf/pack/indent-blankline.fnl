(local {: setup} (require :indent_blankline))

(setup {:char "│"
        :filetype_exclude [:terminal :help :packer :NvimTree
                           :markdown :text :corpus
                           (unpack conf.lisp-filetypes)]
        :buftype_exclude [:terminal :nofile]})
