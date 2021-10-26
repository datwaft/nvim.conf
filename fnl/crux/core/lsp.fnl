(import-macros {: buf-noremap!
                : buf-augroup!
                : buf-set!
                : autocmd!} :crux.lib.macro.vim)

(local {: deep-merge} (require :crux.lib.table))
(local {: exists?
        : prequire} (require :crux.lib.module))
(local {: has?} (require :crux.lib.vim))
(local {: keys} (require :cljlib))
(local lua-dev (require :lua-dev))
(local signature (require :lsp_signature))
(local config (require :lspconfig))

(vim.diagnostic.config {:underline true
                        :virtual_text {:prefix "●"}
                        :signs true
                        :update_in_insert false
                        :severity_sort true})

(vim.fn.sign_define :DiagnosticSignError
                    {:text "" :texthl "DiagnosticSignError"})

(vim.fn.sign_define :DiagnosticSignWarn
                    {:text "" :texthl "DiagnosticSignWarn"})

(vim.fn.sign_define :DiagnosticSignInfo
                    {:text "" :texthl "DiagnosticSignInfo"})

(vim.fn.sign_define :DiagnosticSignHint
                    {:text "" :texthl "DiagnosticSignHint"})

(fn on-attach [client bufnr]
  ;;; Signature
  (signature.on_attach {:bind true
                        :hint_prefix "● "
                        :hint_scheme "DiagnosticSignInfo"}
                       bufnr)

  ;;; Completion
  ;; Enable omnifunc-completion
  (buf-set! omnifunc "v:lua.vim.lsp.omnifunc")

  ;;; Keybinds
  ;; Show documentation
  (buf-noremap! [n] "K" "<cmd>lua vim.lsp.buf.hover()<cr>")
  ;; Open code-actions menu for cursor position
  (if (exists? :telescope)
    (buf-noremap! [n] "<leader>a" "<cmd>Telescope lsp_code_actions<cr>")
    (buf-noremap! [n] "<leader>a" "<cmd>lua vim.lsp.buf.code_action()<cr>"))
  ;; Open code-actions menu for selection
  (if (exists? :telescope)
    (buf-noremap! [v] "<leader>a" "<cmd>Telescope lsp_range_code_actions<cr>")
    (buf-noremap! [v] "<leader>a" "<cmd>lua vim.lsp.buf.range_code_action()<cr>"))
  ;; Rename symbol
  (buf-noremap! [n] "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<cr>")
  ;; Show line diagnostics
  (buf-noremap! [n] "<leader>d" "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
  ;; Go to diagnostic
  (buf-noremap! [n] "[d" "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>")
  (buf-noremap! [n] "]d" "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>")
  ;; List diagnostics
  (if (exists? :telescope)
    (buf-noremap! [n] "<leader>ld" "<cmd>Telescope lsp_document_diagnostics<cr>")
    (buf-noremap! [n] "<leader>ld" "<cmd>lua vim.lsp.diagnostic.set_qflist()<cr>"))
  ;; Go to declaration
  (buf-noremap! [n] "<leader>gD" "<cmd>lua vim.lsp.buf.declaration()<cr>")
  ;; Go to definition
  (buf-noremap! [n] "<leader>gd" "<cmd>lua vim.lsp.buf.definition()<cr>")
  ;; Go to type definition
  (buf-noremap! [n] "<leader>gt" "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  ;; List implementations
  (if (exists? :telescope)
    (buf-noremap! [n] "<leader>li" "<cmd>Telescope lsp_implementations<cr>")
    (buf-noremap! [n] "<leader>li" "<cmd>lua vim.lsp.buf.implementation()<cr>"))
  ;; List references
  (if (exists? :telescope)
    (buf-noremap! [n] "<leader>lr" "<cmd>Telescope lsp_references<cr>")
    (buf-noremap! [n] "<leader>lr" "<cmd>lua vim.lsp.buf.references()<cr>"))
  ;; Format buffer
  (when client.resolved_capabilities.document_formatting
    (buf-noremap! [n] "<leader>=" "<cmd>lua vim.lsp.buf.formatting()<cr>"))
  ;; Format selection
  (when client.resolved_capabilities.document_range_formatting
    (buf-noremap! [v] "<leader>=" "<cmd>lua vim.lsp.buf.range_formatting()<cr>"))

  ;;; Events
  ;; Format buffer on save
  (when client.resolved_capabilities.document_formatting
    (buf-augroup! lsp-format-on-save
                  (autocmd! BufWritePre <buffer>
                            "lua vim.lsp.buf.formatting_seq_sync(nil, 1000, {'null-ls'})")))
  ;; Display hints on CursorHold
  (when (exists? :lsp_extensions)
        (buf-augroup! lsp-display-hints
                      (autocmd! [CursorHold CursorHoldI] *.rs
                                #(let [{: inlay_hints} (require :lsp_extensions)]
                                      (inlay_hints {}))))))

(local capabilities (match (prequire :cmp_nvim_lsp)
                      {: update_capabilities} (update_capabilities (vim.lsp.protocol.make_client_capabilities))))

(local global-options {:on_attach on-attach
                       : capabilities})

;; Docker
(config.dockerls.setup global-options)
;; Nix
(config.rnix.setup global-options)
;; Bash
(config.bashls.setup global-options)
;; C & C++
(config.clangd.setup global-options)
;; Arduino
(config.arduino_language_server.setup global-options)
;; CMake
(config.cmake.setup global-options)
;; Python
(config.pyright.setup global-options)
;; R
(config.r_language_server.setup global-options)
;; Rust
(config.rust_analyzer.setup global-options)
;; Javascript & Typescript
(config.tsserver.setup global-options)
;; Emmet
(config.emmet_ls.setup global-options)
;; ESLint
(config.eslint.setup global-options)
;; CSS
(config.cssls.setup global-options)
;; Html
(config.html.setup global-options)
;; Vue
(config.vuels.setup global-options)
;; Json
(config.jsonls.setup global-options)
;; Yaml
(config.yamlls.setup global-options)
;; Clojure
(config.clojure_lsp.setup global-options)
;; VimL
(config.vimls.setup global-options)
;; Lua
(let [system (if
               (has? "mac") "macOS"
               (has? "unix") "Linux"
               (has? "win32") "Windows")
      root (.. (vim.fn.expand "~") "/.local/bin/lua-language-server")
      binary (.. root "/bin/" system "/lua-language-server")]
  (config.sumneko_lua.setup (deep-merge
                              (lua-dev.setup {:lspconfig (deep-merge
                                                           global-options
                                                           {:cmd [binary "-E" (.. root "/main.lua")]})})
                              {:settings {:Lua {:workspace {:preloadFileSize 500}}}})))

; ;; ------------------------------

{: global-options}
