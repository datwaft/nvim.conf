(module core.plugin.indent-blankline
  {require-macros [core.macros]})

(let! indent_blankline_char "│")
(let! indent_blankline_use_treesitter true)
(let! indent_blankline_filetype_exclude [:help :fern :packer :fennel :markdown])
(let! indent_blankline_buftype_exclude [:terminal])
(let! indent_blankline_show_current_context false)
(let! indent_blankline_context_patterns
  [:class :return :function :method :^if :^while :jsx_element
   :^for :^object :^table :block :arguments :if_statement
   :else_clause :jsx_element :jsx_self_closing_element :try_statement
   :catch_clause :import_statement])
