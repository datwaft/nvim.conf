(fn on-attach [client bufnr]
  ;; Show documentation
  (map! [n] "K" vim.lsp.buf.hover {:buffer bufnr})
  ;; Go to definition
  (map! [n] "gd" vim.lsp.buf.definition {:buffer bufnr})
  ;; Go to declaration
  (map! [n] "gD" vim.lsp.buf.declaration {:buffer bufnr})
  ;; Go to implementation
  (map! [n] "gi" vim.lsp.buf.implementation {:buffer bufnr})
  ;; Go to references
  (map! [n] "gr" vim.lsp.buf.references {:buffer bufnr})
  ;; Rename symbol under cursor
  (map! [n] "<leader>rn" vim.lsp.buf.rename {:buffer bufnr})
  ;; Apply code actions
  (map! [n] "<leader>a" vim.lsp.buf.code_action {:buffer bufnr})
  ;; Toggle inlay hints
  (when (client.supports_method "textDocument/inlayHint")
    (map! [n] "<leader>th" #(vim.lsp.inlay_hint bufnr) {:buffer bufnr}))

  ;; Enable inlay hints by default
  (when (client.supports_method "textDocument/inlayHint")
    (vim.lsp.inlay_hint bufnr true)))
