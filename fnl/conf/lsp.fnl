;;; ====================
;;; Dependency assertion
;;; ====================
(let [{: assert-dependencies!} (require :conf.lib.dep)]
  (when (not (assert-dependencies!
               :conf.lsp [:lua-dev
                          :lsp_signature
                          :lsp_extensions
                          :lspconfig
                          :cmp_nvim_lsp
                          :schemastore])) (lua :return)))

;;; ========================
;;; Diagnostic configuration
;;; ========================
(let [{: config} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline true
           :signs true
           :update_in_insert false
           :severity_sort true
           :float {:show_header false
                   :border "single"}
           :virtual_text false})
  (sign_define :DiagnosticSignError {:text "" :texthl "DiagnosticSignError"})
  (sign_define :DiagnosticSignWarn {:text "" :texthl "DiagnosticSignWarn"})
  (sign_define :DiagnosticSignInfo {:text "" :texthl "DiagnosticSignInfo"})
  (sign_define :DiagnosticSignHint {:text "" :texthl "DiagnosticSignHint"}))

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
  (import-macros {: local-set!} :conf.macro.opt)
  (import-macros {: buf-map!} :conf.macro.keybind)
  (import-macros {: buf-augroup!
                  : autocmd!} :conf.macro.event)

  (local {:document_formatting has-formatting?
          :document_range_formatting has-range-formatting?} client.resolved_capabilities)
  (local {:formatting_seq_sync format-seq-sync!
          :hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :rename rename!} vim.lsp.buf)
  (local {:open_float open-line-diag-float!
          :goto_prev goto-diag-prev!
          :goto_next goto-diag-next!} vim.diagnostic)
  (local {:inlay_hints inlay-hints!} (require :lsp_extensions))
  (local {:lsp_implementations open-impl-float!
          :lsp_references open-ref-float!
          :diagnostics open-diag-float!
          :lsp_document_symbols open-local-symbol-float!
          :lsp_workspace_symbols open-workspace-symbol-float!} (require :telescope.builtin))

  ;;; =========
  ;;; Signature
  ;;; =========
  (let [signature (require :lsp_signature)]
    (signature.on_attach {:bind true
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
  ;; Show line diagnostics
  (buf-map! [n] "<leader>d" open-line-diag-float!)
  ;; Go to diagnostic
  (buf-map! [n] "[d" goto-diag-prev!)
  (buf-map! [n] "]d" goto-diag-next!)
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
  ;; List document diagnostics
  (buf-map! [n] "<leader>ld" (open-diag-float! {:bufnr 0}))
  ;; List workspace diagnostics
  (buf-map! [n] "<leader>lD" open-diag-float!)
  ;; List document symbols
  (buf-map! [n] "<leader>ls" open-local-symbol-float!)
  ;; List workspace symbols
  (buf-map! [n] "<leader>lS" open-workspace-symbol-float!)

  ;;; ======
  ;;; Events
  ;;; ======
  ;; Format buffer before saving
  (when has-formatting?
    (buf-augroup! lsp-format-before-saving
                  (autocmd! BufWritePre <buffer>
                            #(format-seq-sync! nil 1000 [:null-ls]))))
  ;; Display hints on hover
  (buf-augroup! lsp-display-hints
                (autocmd! [CursorHold CursorHoldI] *.rs
                          #(inlay-hints! {}))))

;;; ==========================
;;; Capabilities configuration
;;; ==========================
(local capabilities (let [{: update_capabilities} (require :cmp_nvim_lsp)
                          {: make_client_capabilities} vim.lsp.protocol]
                      (update_capabilities (make_client_capabilities))))

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
(local {: expand} vim.fn)

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
(config.pyright.setup (deep-merge
                        global-options
                        {:settings {:python {:venvPath (expand "$HOME/.pyenv/versions")}}}))
;; R
(config.r_language_server.setup global-options)
;; Rust
(config.rust_analyzer.setup global-options)
;; Javascript & Typescript
(config.tsserver.setup
  (deep-merge
    global-options
    {:on_attach (fn [client bufnr]
                  (set client.resolved_capabilities.document_formatting false)
                  (set client.resolved_capabilities.document_range_formatting false)
                  (on-attach client bufnr))}))
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
