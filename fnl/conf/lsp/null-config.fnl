(fn null-config []
  (local on-attach (require :conf.lsp.on-attach))
  (local null (require :null-ls))

  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
    (let [{: formatting
           : diagnostics
           : hover
           : completion
           :code_actions actions} null.builtins
          typescript-actions (require :typescript.extensions.null-ls.code-actions)]
      [formatting.stylua
       formatting.prettierd
       formatting.markdownlint
       formatting.black
       formatting.isort
       (diagnostics.pylint.with {:prefer_local ".venv/bin"})
       (diagnostics.mypy.with {:prefer_local ".venv/bin"})
       typescript-actions
       formatting.fourmolu]))

  ;;; =====
  ;;; Setup
  ;;; =====
  (null.setup {:sources sources
               :on_attach on-attach}))

