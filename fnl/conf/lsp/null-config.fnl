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
       (formatting.prettierd.with {:condition (fn [utils]
                                                (not (utils.root_has_file ["deno.json" "deno.jsonc"])))})
       formatting.markdownlint
       formatting.black
       formatting.isort
       (diagnostics.pylint.with {:prefer_local ".venv/bin"})
       (diagnostics.mypy.with {:prefer_local ".venv/bin"})
       (typescript-actions.with {:condition (fn [utils]
                                              (not (utils.root_has_file ["deno.json" "deno.jsonc"])))})
       formatting.clang_format]))

  ;;; =====
  ;;; Setup
  ;;; =====
  (null.setup {:sources sources
               :on_attach on-attach}))

