;;; ====================
;;; Dependency assertion
;;; ====================
(let [{: assert-dependencies!} (require :conf.lib.dep)]
  (when (not (assert-dependencies!
               :conf.lsp [:lua-dev
                          :lsp_signature
                          :lspconfig
                          :typescript
                          :cmp_nvim_lsp
                          :schemastore])) (lua :return)))

;;; =======================
;;; Aesthetic configuration
;;; =======================
(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border "single"}))
(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border "single"}))

;;; =======================
;;; On-attach configuration
;;; =======================
(fn on-attach [client bufnr]
  (import-macros {: local-set!} :themis.opt)
  (import-macros {: buf-map!} :themis.keybind)
  (import-macros {: augroup!
                  : clear!
                  : autocmd!} :themis.event)

  (local {: contains?} (require :themis.lib.seq))

  (local telescope (require :telescope.builtin))

  ;;; =========
  ;;; Signature
  ;;; =========
  (let [signature (require :lsp_signature)]
    (signature.on_attach {:bind true
                          :doc_lines 0
                          :floating_window_above_cur_line true
                          :fix_pos true
                          :hint_enable false
                          :hint_prefix "● "
                          :hint_scheme "DiagnosticSignInfo"}
                         bufnr))

  ;;; ==========
  ;;; Completion
  ;;; ==========
  ;; Enable omnifunc-completion
  (local-set! omnifunc "v:lua.vim.lsp.omnifunc")

  ;;; ========
  ;;; Keybinds
  ;;; ========
  ;; Show documentation
  (buf-map! [n] "K" vim.lsp.buf.hover)
  ;; Open code-actions menu
  (buf-map! [nv] "<leader>a" vim.lsp.buf.code_action)
  ;; Rename symbol
  (buf-map! [nv] "<leader>rn" vim.lsp.buf.rename)
  ;; Go to declaration
  (buf-map! [n] "<leader>gD" vim.lsp.buf.declaration)
  ;; Go to definition
  (buf-map! [n] "<leader>gd" vim.lsp.buf.definition)
  ;; Go to type definition
  (buf-map! [n] "<leader>gt" vim.lsp.buf.type_definition)
  ;; List implementations
  (buf-map! [n] "<leader>li" telescope.lsp_implementations)
  ;; List references
  (buf-map! [n] "<leader>lr" telescope.lsp_references)
  ;; List buffer symbols
  (buf-map! [n] "<leader>ls" telescope.lsp_document_symbols)
  ;; List workspace symbols
  (buf-map! [n] "<leader>lS" telescope.lsp_workspace_symbols)

  ;;; ======
  ;;; Events
  ;;; ======
  ;; Format buffer before saving
  (when (client.supports_method "textDocument/formatting")
    (augroup! lsp-format-before-saving
      (clear! {:buffer bufnr})
      (autocmd! BufWritePre <buffer>
        '(vim.lsp.buf.format {:filter (fn [client] (not (contains? [:jsonls :tsserver] client.name)))
                              :bufnr bufnr})
        {:buffer bufnr}))))

;;; ==========================
;;; Capabilities configuration
;;; ==========================
(local capabilities (let [cmp (require :cmp_nvim_lsp)]
                      (cmp.update_capabilities (vim.lsp.protocol.make_client_capabilities))))
(set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                             :lineFoldingOnly true})

;;; =========================
;;; Global options definition
;;; =========================
(local global-options {:on_attach on-attach
                       : capabilities})

;;; ====================
;;; Client configuration
;;; ====================
(local {: deep-merge} (require :conf.lib.table))
(local config (require :lspconfig))

;; Docker
(config.dockerls.setup global-options)
;; Nix
(config.rnix.setup global-options)
;; Bash
(config.bashls.setup global-options)
;; C & C++
(config.clangd.setup global-options)
;; CMake
(config.cmake.setup global-options)
;; Python
(config.pyright.setup (deep-merge
                        global-options
                        {:settings {:python {:venvPath (vim.fn.expand "$HOME/.pyenv/versions")}}}))
;; Rust
(config.rust_analyzer.setup global-options)
;; Javascript & Typescript
(let [typescript (require :typescript)]
  (typescript.setup {:server global-options}))
;; ESLint
(config.eslint.setup global-options)
;; CSS
(config.cssls.setup global-options)
;; Html
(config.html.setup global-options)
;; Emmet
(config.emmet_ls.setup global-options)
;; Vue
(config.volar.setup global-options)
;; Svelte
(config.svelte.setup global-options)
;; Json
(let [{: json} (require :schemastore)]
  (config.jsonls.setup
    (deep-merge
      global-options
      {:settings {:json {:schemas (json.schemas)}}})))
;; Yaml
(config.yamlls.setup global-options)
;; Toml
(config.taplo.setup global-options)
;; Clojure
(config.clojure_lsp.setup global-options)
;; VimL
(config.vimls.setup global-options)
;; Lua
(let [lua-dev (require :lua-dev)]
  (config.sumneko_lua.setup
    (deep-merge
      (lua-dev.setup {:lspconfig (deep-merge
                                   global-options
                                   {:cmd ["lua-language-server"]})})
      {:settings {:Lua {:workspace {:preloadFileSize 500}}}})))

;;; ------------------------------

{: global-options}
