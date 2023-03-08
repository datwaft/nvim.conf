(import-macros {: pack} :themis.pack.lazy)

(fn lsp-config []
  (local on-attach (require :conf.lsp.on-attach))
  (local lsp (require :lspconfig))

  (local capabilities (let [(ok? cmp) (pcall require "cmp_nvim_lsp")]
                        (if ok? (cmp.default_capabilities)
                          (vim.lsp.protocol.make_client_capabilities))))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})

  ;;; ====================
  ;;; Client configuration
  ;;; ====================
  ;; Lua
  (let [neodev (require :neodev)]
    (neodev.setup {})
    (lsp.lua_ls.setup {:on_attach on-attach : capabilities
                       :settings {:Lua {:workspace {:preloadFileSize 500}}}}))
  ;; Json
  (lsp.jsonls.setup {:on_attach on-attach : capabilities
                     :settings {:json {:schemas (let [{: json} (require :schemastore)] (json.schemas))}}})
  ;; Docker
  (lsp.dockerls.setup {:on_attach on-attach : capabilities})
  ;; Nix
  (lsp.rnix.setup {:on_attach on-attach : capabilities})
  ;; Bash
  (lsp.bashls.setup {:on_attach on-attach : capabilities})
  ;; C & C++
  (lsp.clangd.setup {:on_attach on-attach : capabilities
                     :cmd ["clangd"
                           "--clang-tidy"]})
  ;; CMake
  (lsp.cmake.setup {:on_attach on-attach : capabilities})
  ;; Python
  (lsp.pyright.setup {:on_attach on-attach : capabilities})
  ;; Rust
  (lsp.rust_analyzer.setup {:on_attach on-attach : capabilities
                            :settings {:rust-analyzer {:cargo {:allFeatures true}
                                                       :checkOnSave {:command "clippy"}}}})
  ;; Typescript
  (let [typescript (require :typescript)]
    (typescript.setup {:server {:on_attach on-attach : capabilities
                                :root_dir (lsp.util.root_pattern "package.json")
                                :single_file_support false}}))
  (lsp.denols.setup {:on_attach on-attach : capabilities
                     :root_dir (lsp.util.root_pattern "deno.json" "deno.jsonc")})
  ;; ESLint
  (lsp.eslint.setup {:on_attach on-attach : capabilities})
  ;; CSS
  (lsp.cssls.setup {:on_attach on-attach : capabilities})
  ;; HTML
  (lsp.html.setup {:on_attach on-attach : capabilities})
  ;; Emmet
  (lsp.emmet_ls.setup {:on_attach on-attach : capabilities})
  ;; Vue
  (lsp.volar.setup {:on_attach on-attach : capabilities})
  ;; Svelte
  (lsp.svelte.setup {:on_attach on-attach : capabilities})
  ;; Yaml
  (lsp.yamlls.setup {:on_attach on-attach : capabilities})
  ;; Toml
  (lsp.taplo.setup {:on_attach on-attach : capabilities})
  ;; XML
  (lsp.lemminx.setup {:on_attach on-attach : capabilities})
  ;; Clojure
  (lsp.clojure_lsp.setup {:on_attach on-attach : capabilities})
  ;; VimL
  (lsp.vimls.setup {:on_attach on-attach : capabilities})
  ;; Go
  (lsp.gopls.setup {:on_attach on-attach : capabilities})
  ;; R
  (lsp.r_language_server.setup {:on_attach on-attach : capabilities}))

(fn null-config []
  (local on-attach (require :conf.lsp.on-attach))
  (local null (require :null-ls))

  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
    (let [{: formatting
           : diagnostics
           : hover
           : completion
           :code_actions actions} null.builtins
          typescript-actions (require :typescript.extensions.null-ls.code-actions)]
      [formatting.stylua
       (formatting.prettierd.with {:condition (fn [utils]
                                                (not (utils.root_has_file ["deno.json" "deno.jsonc"])))})
       formatting.markdownlint
       formatting.black
       formatting.isort
       (diagnostics.pylint.with {:prefer_local ".venv/bin"})
       (diagnostics.mypy.with {:prefer_local ".venv/bin"})
       (typescript-actions.with {:condition (fn [utils]
                                              (not (utils.root_has_file ["deno.json" "deno.jsonc"])))})]))

  ;;; =====
  ;;; Setup
  ;;; =====
  (null.setup {:sources sources
               :on_attach on-attach}))

[;; Configuration
 (pack "neovim/nvim-lspconfig" {:config lsp-config
                                :dependencies ["folke/neodev.nvim"
                                               "williamboman/mason-lspconfig.nvim"
                                               (pack "j-hui/fidget.nvim" {:config true})
                                               (pack "narutoxy/dim.lua" {:config true})
                                               "jose-elias-alvarez/typescript.nvim"
                                               "b0o/schemastore.nvim"]})
 ;; Installation
 (pack "williamboman/mason.nvim" {:config true})
 (pack "williamboman/mason-lspconfig.nvim" {:opts {:automatic_installation true}
                                            :dependencies ["williamboman/mason.nvim"]})
 (pack "jay-babu/mason-null-ls.nvim" {:opts {:automatic_installation true}
                                      :dependencies ["williamboman/mason.nvim"
                                                     "jose-elias-alvarez/null-ls.nvim"]})
 ;; Non-LSP integration
 (pack "jose-elias-alvarez/null-ls.nvim" {:config null-config
                                          :dependencies ["nvim-lua/plenary.nvim"]})]
