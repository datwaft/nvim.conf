;;; ====================
;;; Dependency assertion
;;; ====================
(local {: warn!} (require :conf.lib.io))
(fn nil? [x] (= nil x))

(when (nil? (require :conf.lsp))
  (warn! "Could not load conf.pack.null-ls as conf.lsp could not be loaded.")
  (lua :return))

;;; =============
;;; Configuration
;;; =============
(local {: deep-merge} (require :conf.lib.table))
(local {: setup
        :builtins {: formatting
                   : diagnostics
                   : hover
                   : completion
                   :code_actions actions}} (require :null-ls))
(local {:global-options {:on_attach on-attach}} (require :conf.lsp))

(local sources [formatting.stylua
                formatting.prettierd
                formatting.markdownlint
                formatting.black
                formatting.isort
                diagnostics.pylint])

(setup {: sources
        :on_attach on-attach})
