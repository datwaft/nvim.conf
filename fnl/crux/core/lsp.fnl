(import-macros {: buf-noremap!
                : buf-augroup!
                : buf-set!
                : autocmd!} :crux.lib.macro.vim)

(local {: deep-merge} (require :crux.lib.table))
(local {: has?} (require :crux.lib.vim))
(local {: keys} (require :cljlib))
(local lua-dev (require :lua-dev))
(local config (require :lspconfig))

(fn on-attach [client bufnr]
  ;;; Completion
  ;; Enable omnifunc-completion
  (buf-set! omnifunc "v:lua.vim.lsp.omnifunc")
  ;;; Keybinds
  ;; Show documentation
  (buf-noremap! [n] "K" "<cmd>lua vim.lsp.buf.hover()<cr>")
  ;; Open code-actions menu for cursor position
  (buf-noremap! [n] "<leader>a" "<cmd>lua vim.lsp.buf.code_action()<cr>")
  ;; Open code-actions menu for selection
  (buf-noremap! [v] "<leader>a" "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
  ;; Rename symbol
  (buf-noremap! [n] "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<cr>")
  ;; Show line diagnostics
  (buf-noremap! [n] "<leader>d" "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
  ;; Go to diagnostic
  (buf-noremap! [n] "[d" "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>")
  (buf-noremap! [n] "]d" "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>")
  ;; List diagnotics
  (buf-noremap! [n] "<leader>ld" "<cmd>lua vim.lsp.diagnostic.set_qflist()<cr>")
  ;; Go to declaration
  (buf-noremap! [n] "<leader>gD" "<cmd>lua vim.lsp.buf.declaration()<cr>")
  ;; Go to definition
  (buf-noremap! [n] "<leader>gd" "<cmd>lua vim.lsp.buf.definition()<cr>")
  ;; Go to type definition
  (buf-noremap! [n] "<leader>gt" "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  ;; List implementations
  (buf-noremap! [n] "<leader>li" "<cmd>lua vim.lsp.buf.implementation()<cr>")
  ;; List references
  (buf-noremap! [n] "<leader>lr" "<cmd>lua vim.lsp.buf.references()<cr>")
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
                            "lua vim.lsp.buf.formatting_seq_sync(nil, 1000)"))))

(local global-options {:on_attach on-attach})

;; Bash
(config.bashls.setup global-options)
;; C & C++
(config.clangd.setup global-options)
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
;; Vue
(config.vuels.setup global-options)
;; Json
(config.jsonls.setup global-options)
;; Clojure
(config.clojure_lsp.setup global-options)
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
;; EFM
(let [luafmt {:formatCommand "lua-format -i"
              :formatStdin true}
      prettierd {:formatCommand "prettierd \"${INPUT}\""
                 :formatStdin true}
      languages {:lua [luafmt]
                 :javascript [prettierd]
                 :typescript [prettierd]
                 :css [prettierd]
                 :html [prettierd]
                 :json [prettierd]
                 :yaml [prettierd]}]
  (config.efm.setup (deep-merge
                      global-options
                      {:init_options {:documentFormatting true
                                      :codeAction true}
                       :settings {:rootMarkers [".git/"]
                                  :log_level 1
                                  :log_file "~/efm.log"
                                  :languages languages}
                       :filetypes (keys languages)})))
