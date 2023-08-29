(local {: contains?} (require :themis.lib.seq))

(fn format! [bufnr ?async?]
  (vim.lsp.buf.format {: bufnr
                       :filter #(not (contains? [:jsonls :tsserver :typescript-tools] $.name))
                       :async ?async?}))

(fn autoformat! [bufnr ?async?]
  (when (not vim.g.lsp_autoformat_disable)
    (format! bufnr ?async?)))

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
  (buf-map! [n] "gD" vim.lsp.buf.declaration)
  ;; Go to implementation
  (buf-map! [n] "gi" vim.lsp.buf.implementation)
  ;; Go to references
  (buf-map! [n] "gr" vim.lsp.buf.references)
  ;; Rename symbol under cursor
  (buf-map! [n] "<leader>rn" vim.lsp.buf.rename)
  ;; Apply code actions
  (buf-map! [n] "<leader>a" vim.lsp.buf.code_action)
  ;; Toggle inlay hints
  (when (client.supports_method "textDocument/inlayHint")
    (buf-map! [n] "<leader>th" #(vim.lsp.inlay_hint bufnr)))

  ;;; ============
  ;;; Capabilities
  ;;; ============

  ;; Enable inlay hints
  (when (client.supports_method "textDocument/inlayHint")
    (vim.lsp.inlay_hint bufnr true))

  ;;; ======
  ;;; Events
  ;;; ======
  (import-macros {: augroup!
                  : clear!
                  : autocmd!} :themis.event)

  ;; Format before saving
  (when (client.supports_method "textDocument/formatting")
    (augroup! format-before-saving
      (clear! {:buffer bufnr})
      (autocmd! BufWritePre <buffer> #(autoformat! bufnr) {:buffer bufnr}))))
