(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local on-attach (require :conf.lsp.on-attach))
  (local lsp (require :lspconfig))

  (local capabilities (let [(ok? cmp) (pcall require "cmp_nvim_lsp")]
                        (if ok? (cmp.default_capabilities)
                          (vim.lsp.protocol.make_client_capabilities))))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})

  ;; Lua
  (let [neodev (require :neodev)]
    (neodev.setup {})
    (lsp.sumneko_lua.setup {:on_attach on-attach
                            : capabilities
                            :settings {:Lua {:workspace {:preloadFileSize 500}}}})))

[;; Configuration
 (pack "neovim/nvim-lspconfig" {: config
                                :dependencies ["folke/neodev.nvim"
                                               "williamboman/mason-lspconfig.nvim"
                                               (pack "j-hui/fidget.nvim" {:config true})
                                               (pack "narutoxy/dim.lua" {:config true})]})
 ;; Installation
 (pack "williamboman/mason.nvim" {:config true}) 
 (pack "williamboman/mason-lspconfig.nvim" {:config {:automatic_installation true}
                                            :dependencies ["williamboman/mason.nvim"]})]
