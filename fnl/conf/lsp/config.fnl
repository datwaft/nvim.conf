(fn lsp-config []
  (local on-attach (require :conf.lsp.on-attach))
  (local capabilities (require :conf.lsp.capabilities))

  ;;; ====================
  ;;; Client configuration
  ;;; ====================
  (local lsp (require :lspconfig))

  ;; --------------------------
  ;; With default configuration
  ;; --------------------------
  (local with-default [:dockerls :rnix :bashls :cmake :pyright
                       :eslint :cssls :html :volar :svelte :taplo
                       :lemminx :clojure_lsp :vimls :gopls :r_language_server
                       :jdtls :clangd :zls :hls])
  (each [_ server (ipairs with-default)]
    ((. lsp server :setup) {:on_attach on-attach
                            :capabilities capabilities}))

  ;; ------------------------------
  ;; With exceptional configuration
  ;; ------------------------------
  ; Lua
  (let [neodev (require :neodev)]
    (neodev.setup {})
    (lsp.lua_ls.setup {:on_attach on-attach : capabilities
                       :settings {:Lua {:workspace {:preloadFileSize 500}
                                        :hint {:enable true}}}}))
  ; Json
  (lsp.jsonls.setup {:on_attach on-attach : capabilities
                     :settings {:json {:schemas (let [{: json} (require :schemastore)] (json.schemas))}}})
  ; Rust
  (lsp.rust_analyzer.setup {:on_attach on-attach : capabilities
                            :settings {:rust-analyzer {:cargo {:allFeatures true}
                                                       :checkOnSave {:command "clippy"}}}})
  ; Emmet
  (lsp.emmet_ls.setup {:on_attach on-attach : capabilities
                       :filetypes ["html" "typescriptreact" "javascriptreact"
                                   "css" "sass" "scss" "less" "eruby"
                                   "xml" "svelte"]})
  ; YAML
  (lsp.yamlls.setup {:on_attach on-attach : capabilities
                     :settings {:yaml {:keyOrdering false}}})
  ; Markdown & Quarto
  (lsp.marksman.setup {:on_attach on-attach : capabilities
                       :filetypes ["markdown" "quarto"]})
  ; Swift
  (lsp.sourcekit.setup {:on_attach on-attach : capabilities
                        :filetypes ["swift"]}))
