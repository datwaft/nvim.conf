(import-macros {: pack} :themis.pack)

(fn config []
  (local on-attach (require :conf.lsp.on-attach))
  (local lsp (require :lspconfig)))

[(pack "neovim/nvim-lspconfig" {: config})
 (pack "williamboman/mason.nvim" {:config #(let [{: setup} (require :mason)] (setup))})
 (pack "williamboman/mason-lspconfig.nvim" {:config #(let [{: setup} (require :mason-lspconfig)] (setup))
                                            :dependencies ["neovim/nvim-lspconfig"
                                                           "williamboman/mason.nvim"]})]
