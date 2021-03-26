-- ==============================
-- INDENT BLANKLINE CONFIGURATION
-- ==============================
-- Created by datwaft <github.com/datwaft>

return function()
  vim.g.indent_blankline_char = '│'
  vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_filetype_exclude = {
    'help',
    'fern',
    'packer',
  }
  vim.g.indent_blankline_buftype_exclude = {
    'terminal',
  }
  vim.g.indent_blankline_show_current_context = false
  vim.g.indent_blankline_context_patterns = {
    'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element',
    '^for', '^object', '^table', 'block', 'arguments', 'if_statement',
    'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement',
    'catch_clause', 'import_statement',
  }
end
