(local {: setup} (require :indent_blankline))

(setup {:char "▏"
        :show_current_context true
        :show_current_context_start true
        :filetype_exclude [:terminal :help :packer :NvimTree
                           :markdown :text :corpus
                           :TelescopePrompt :TelescopeResults
                           (unpack conf.lisp-filetypes)]
        :buftype_exclude [:terminal :nofile]})
