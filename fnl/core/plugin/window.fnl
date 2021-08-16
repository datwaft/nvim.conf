(module core.plugin.window
   {require-macros [core.macros]})

(noremap! [nvo] "<C-w>f" "<cmd>lua require'nvim-window'.pick()<cr>")
