(module core.plugin.indent-blankline)

(set vim.g.indent_blankline_char "│")
(set vim.g.indent_blankline_use_treesitter true)
(set vim.g.indent_blankline_filetype_exclude [:help :fern :packer :fennel :markdown])
(set vim.g.indent_blankline_buftype_exclude [:terminal])
(set vim.g.indent_blankline_show_current_context false)
(set vim.g.indent_blankline_context_patterns
     [:class :return :function :method :^if :^while :jsx_element
      :^for :^object :^table :block :arguments :if_statement
      :else_clause :jsx_element :jsx_self_closing_element :try_statement
      :catch_clause :import_statement])
