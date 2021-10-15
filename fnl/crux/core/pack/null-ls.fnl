(local {: config
        :builtins {: formatting
                   : diagnostics
                   :code_actions actions}} (require :null-ls))
(local {: global-options} (require :crux.core.lsp))
(local lspconfig (require :lspconfig))

(config {:sources [formatting.stylua
                   formatting.prettierd
                   formatting.markdownlint
                   diagnostics.write_good]})

(lspconfig.null-ls.setup global-options)
