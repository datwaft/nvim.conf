(import-macros {: pack} :themis.pack.lazy)

[;; Configuration
 (pack "neovim/nvim-lspconfig" {:config (require :conf.lsp.config)
                                :dependencies ["folke/neodev.nvim"
                                               "williamboman/mason-lspconfig.nvim"
                                               (pack "j-hui/fidget.nvim" {:config true
                                                                          :tag "legacy"})
                                               "b0o/schemastore.nvim"
                                               (pack "pmizio/typescript-tools.nvim" {:dependencies ["nvim-lua/plenary.nvim"]})]})
 ;; Installation
 (pack "williamboman/mason.nvim" {:config true})
 (pack "williamboman/mason-lspconfig.nvim" {:opts {:automatic_installation true}
                                            :dependencies ["williamboman/mason.nvim"]})
 (pack "jay-babu/mason-null-ls.nvim" {:opts {:automatic_installation true
                                             :automatic_setup false}
                                      :dependencies ["williamboman/mason.nvim"
                                                     "jose-elias-alvarez/null-ls.nvim"]})
 ;; Non-LSP integration
 (pack "jose-elias-alvarez/null-ls.nvim" {:config (require :conf.lsp.null-config)
                                          :dependencies ["nvim-lua/plenary.nvim"]})]
