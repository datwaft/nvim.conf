(module core.plugin.window
   {require-macros [core.macros]})

(noremap! [nvo] "<leader>w" "<cmd>lua require'nvim-window'.pick()<cr>" :silent)
