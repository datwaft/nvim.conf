(module core.plugin.file-explorer
  {autoload {m vimp}})

(m.nnoremap [:override] "<C-n>" "<cmd>NvimTreeToggle<cr>")
