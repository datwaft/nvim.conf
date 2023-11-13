(fn setup [plugin opts]
  (set! formatexpr "v:lua.require('conform').formatexpr()")
  ((. setup (require plugin)) opts))

(pack "stevearc/conform.nvim"
      {:opts {:formatters_by_ft {:javascript      [[:prettierd :prettier]]
                                 :typescript      [[:prettierd :prettier]]
                                 :typescriptreact [[:prettierd :prettier]]
                                 :javascriptreact [[:prettierd :prettier]]
                                 :html            [[:prettierd :prettier]]
                                 :json            [[:prettierd :prettier]]
                                 :jsonc           [[:prettierd :prettier]]
                                 :css             [[:prettierd :prettier]]
                                 :bib             [:bibtex-tidy]
                                 :tex             [:latexindent]
                                 :lua             [:stylua]}
              :formatters {:latexindent {:prepend_args ["-l" "-m"]}}
              :format_on_save {:lsp_fallback true
                               :timeout 500
                               :quiet true}}
       : setup})
