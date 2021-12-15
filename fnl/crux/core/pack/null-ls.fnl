(local {: deep-merge} (require :crux.lib.table))
(local {: setup
        :builtins {: formatting
                   : diagnostics
                   : hover
                   : completion
                   :code_actions actions}} (require :null-ls))
(local {:global-options {:on_attach on-attach}} (require :crux.core.lsp))

(local sources [formatting.stylua
                formatting.prettierd
                formatting.markdownlint
                formatting.black
                formatting.sqlformat])

(setup {: sources
        :on_attach on-attach})
