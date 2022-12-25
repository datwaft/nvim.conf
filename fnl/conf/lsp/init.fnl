(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local on-attach (require :conf.lsp.on-attach))
  (local lsp (require :lspconfig))

  ;; Lua
  (let [neodev (require :neodev)]
    (neodev.setup {})
    (lsp.sumneko_lua.setup {:on_attach on-attach
                            :settings {:Lua {:workspace {:preloadFileSize 500}}}})))

[;; Configuration
 (pack "neovim/nvim-lspconfig" {: config
                                :dependencies ["folke/neodev.nvim"
                                               "williamboman/mason-lspconfig.nvim"]})
 ;; Installation
 (pack "williamboman/mason.nvim" {:config true}) 
 (pack "williamboman/mason-lspconfig.nvim" {:config {:automatic_installation true}
                                            :dependencies ["williamboman/mason.nvim"]})]
