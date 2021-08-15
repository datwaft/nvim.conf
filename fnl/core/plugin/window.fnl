(module core.plugin.window
   {require-macros [core.macros]})

(noremap! [nvo :silent] "<C-w>f" "<cmd>lua require'nvim-window'.pick()<cr>")
