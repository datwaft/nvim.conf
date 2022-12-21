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
(local typescript-actions (require :typescript.extensions.null-ls.code-actions))
(local {:global-options {:on_attach on-attach}} (require :conf.lsp))

(local sources [formatting.stylua
                (formatting.prettierd.with {:condition (fn [utils]
                                                         (not (utils.root_has_file ["deno.json" "deno.jsonc"])))})
                formatting.markdownlint
                formatting.black
                formatting.isort
                (diagnostics.pylint.with {:prefer_local ".venv/bin"})
                (diagnostics.mypy.with {:prefer_local ".venv/bin"})
                (typescript-actions.with {:condition (fn [utils]
                                                       (not (utils.root_has_file ["deno.json" "deno.jsonc"])))})])

(setup {: sources
        :on_attach on-attach})
