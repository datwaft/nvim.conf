(module core.plugin.colorscheme
  {autoload {nvim aniseed.nvim}
   require-macros [core.macros]})

(let! edge_style :default)
(let! edge_enable_italic 1)
(let! edge_current_word :underline)
(let! edge_diagnostic_virtual_text :colored)
(nvim.ex.colorscheme :edge)
