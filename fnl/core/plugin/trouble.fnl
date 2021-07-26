(module core.plugin.trouble
  {autoload {plugin trouble}
   require-macros [core.macros]})

(plugin.setup {})

(noremap! [n] "<leader>xx" "<cmd>TroubleToggle<cr>" :silent)
(noremap! [n] "<leader>xw" "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>" :silent)
(noremap! [n] "<leader>xd" "<cmd>TroubleToggle lsp_document_diagnostics<cr>" :silent)
(noremap! [n] "<leader>xq" "<cmd>TroubleToggle quickfix<cr>" :silent)
(noremap! [n] "<leader>xl" "<cmd>TroubleToggle loclist<cr>" :silent)
(noremap! [n] "gR" "<cmd>TroubleToggle lsp_references<cr>" :silent)
