(module core.plugin.colorscheme
  {autoload {nvim aniseed.nvim}})

(set vim.g.edge_style :default)
(set vim.g.edge_enable_italic 1)
(set vim.g.edge_current_word :underline)
(set vim.g.edge_diagnostic_virtual_text :colored)
(nvim.ex.colorscheme :edge)
