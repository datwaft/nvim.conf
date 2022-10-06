(local {: setup} (require :indent_blankline))

(setup {:char "▏"
        :filetype_exclude [:terminal :help :packer :NvimTree
                           :markdown :text :corpus
                           :TelescopePrompt :TelescopeResults
                           (unpack conf.lisp-filetypes)]
        :buftype_exclude [:terminal :nofile]})
