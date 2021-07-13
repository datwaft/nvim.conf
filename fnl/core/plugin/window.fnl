(module core.plugin.window
  {autoload {m vimp}})

(m.nmap [:override :silent] "<leader>w" "<cmd>lua require('nvim-window').pick()<cr>")
(m.vmap [:override :silent] "<leader>w" "<cmd>lua require('nvim-window').pick()<cr>")
(m.omap [:override :silent] "<leader>w" "<cmd>lua require('nvim-window').pick()<cr>")
