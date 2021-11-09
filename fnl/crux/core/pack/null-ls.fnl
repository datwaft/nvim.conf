(local {: config
        :builtins {: formatting
                   : diagnostics
                   : hover
                   : completion
                   :code_actions actions}} (require :null-ls))
(local {: global-options} (require :crux.core.lsp))
(local lspconfig (require :lspconfig))

(config {:sources [formatting.stylua
                   formatting.prettier
                   formatting.markdownlint
                   formatting.black
                   diagnostics.write_good]})

(lspconfig.null-ls.setup global-options)
