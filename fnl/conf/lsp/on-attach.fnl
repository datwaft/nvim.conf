(fn on-attach [client bufnr]
  ;;; ========
  ;;; Keybinds
  ;;; ========
  (import-macros {: buf-map!} :themis.keybind)

  ;; Show documentation
  (buf-map! [n] "K" vim.lsp.buf.hover)
  ;; Go to definition
  (buf-map! [n] "gd" vim.lsp.buf.definition)
  ;; Go to declaration
  (buf-map! [n] "gD" vim.lsp.buf.declaration))
