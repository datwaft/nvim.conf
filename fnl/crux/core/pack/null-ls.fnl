(local {: config
        :builtins {: formatting
                   : diagnostics
                   :code_actions actions}} (require :null-ls))
(local {: global-options} (require :crux.core.lsp))
(local lspconfig (require :lspconfig))

(config {:sources [formatting.stylua
                   formatting.prettierd
                   formatting.markdownlint
                   formatting.sqlformat
                   formatting.shfmt
                   diagnostics.shellcheck
                   diagnostics.write_good
                   diagnostics.markdownlint]})

(lspconfig.null-ls.setup global-options)
