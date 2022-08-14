;;; ====================
;;; Dependency assertion
;;; ====================
(let [{: assert-dependencies!} (require :conf.lib.dep)]
  (when (not (assert-dependencies!
               :conf.lsp [:lua-dev
                          :lsp_signature
                          :lsp_extensions
                          :lspconfig
                          :typescript
                          :cmp_nvim_lsp
                          :schemastore])) (lua :return)))

;;; =======================
;;; Aesthetic configuration
;;; =======================
(let [{: with
       : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp (with handlers.signature_help {:border "single"}))
  (set vim.lsp.handlers.textDocument/hover (with handlers.hover {:border "single"})))

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

  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :rename rename!} vim.lsp.buf)
  (local {:inlay_hints inlay-hints!} (require :lsp_extensions))
  (local {:lsp_implementations open-impl-float!
          :lsp_references open-ref-float!
          :lsp_document_symbols open-local-symbol-float!
          :lsp_workspace_symbols open-workspace-symbol-float!} (require :telescope.builtin))

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
  (buf-map! [n] "K" open-doc-float!)
  ;; Open code-actions menu
  (buf-map! [nv] "<leader>a" open-code-action-float!)
  ;; Rename symbol
  (buf-map! [nv] "<leader>rn" rename!)
  ;; Go to declaration
  (buf-map! [n] "<leader>gD" goto-declaration!)
  ;; Go to definition
  (buf-map! [n] "<leader>gd" goto-definition!)
  ;; Go to type definition
  (buf-map! [n] "<leader>gt" goto-type-definition!)
  ;; List implementations
  (buf-map! [n] "<leader>li" open-impl-float!)
  ;; List references
  (buf-map! [n] "<leader>lr" open-ref-float!)
  ;; List document symbols
  (buf-map! [n] "<leader>ls" open-local-symbol-float!)
  ;; List workspace symbols
  (buf-map! [n] "<leader>lS" open-workspace-symbol-float!)

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
        {:buffer bufnr})))
  ;; Display hints on hover
  (augroup! lsp-display-hints
    (autocmd! [CursorHold CursorHoldI] *.rs
      '(inlay-hints! {}))))

;;; ==========================
;;; Capabilities configuration
;;; ==========================
(local capabilities (let [{: update_capabilities} (require :cmp_nvim_lsp)
                          {: make_client_capabilities} vim.lsp.protocol]
                      (update_capabilities (make_client_capabilities))))
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
(local {: util} config)
(local {: expand} vim.fn)

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
                        {:settings {:python {:venvPath (expand "$HOME/.pyenv/versions")}}}))
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
