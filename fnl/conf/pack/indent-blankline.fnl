(local {: setup} (require :indent_blankline))

(setup {:char "│"
        :char_blankline "┆"
        :use_treesitter_scope true
        :show_current_context true
        :filetype_exclude [:terminal :help :packer :NvimTree
                           :markdown :text :corpus
                           :TelescopePrompt :TelescopeResults
                           (unpack conf.lisp-filetypes)]
        :buftype_exclude [:terminal :nofile]})
