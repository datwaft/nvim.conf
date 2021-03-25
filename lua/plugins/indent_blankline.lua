-- ==============================
-- INDENT BLANKLINE CONFIGURATION
-- ==============================
-- Created by datwaft <github.com/datwaft>

return function()
  vim.g.indent_blankline_char = '│'
  vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_show_first_indent_level = false
  vim.g.indent_blankline_filetype_exclude = {
    'help',
    'fern',
    'packer',
  }
end
