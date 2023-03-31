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
  (local with-default [:dockerls :rnix :bashls :clangd :cmake :pyright
                       :eslint :cssls :html :volar :svelte :taplo
                       :lemminx :clojure_lsp :vimls :gopls :r_language_server])
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
                       :settings {:Lua {:workspace {:preloadFileSize 500}}}}))
  ; Json
  (lsp.jsonls.setup {:on_attach on-attach : capabilities
                     :settings {:json {:schemas (let [{: json} (require :schemastore)] (json.schemas))}}})
  ; Rust
  (lsp.rust_analyzer.setup {:on_attach on-attach : capabilities
                            :settings {:rust-analyzer {:cargo {:allFeatures true}
                                                       :checkOnSave {:command "clippy"}}}})
  ; Typescript
  (let [typescript (require :typescript)]
    (typescript.setup {:server {:on_attach on-attach : capabilities
                                :root_dir (lsp.util.root_pattern "package.json")
                                :single_file_support false}}))
  (lsp.denols.setup {:on_attach on-attach : capabilities
                     :root_dir (lsp.util.root_pattern "deno.json" "deno.jsonc")})
  ; Emmet
  (lsp.emmet_ls.setup {:on_attach on-attach : capabilities
                       :filetypes ["html" "typescriptreact" "javascriptreact"
                                   "css" "sass" "scss" "less" "eruby"
                                   "xml"]})
  ; YAML
  (lsp.yamlls.setup {:on_attach on-attach : capabilities
                     :settings {:yaml {:keyOrdering false}}}))
