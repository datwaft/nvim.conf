(pack "stevearc/conform.nvim"
      {:opts {:formatters_by_ft {:javascript [[:prettierd :prettier]]
                                 :typescript [[:prettierd :prettier]]
                                 :json       [[:prettierd :prettier]]}
              :format_on_save {:lsp_fallback true
                               :timeout 500
                               :quiet true}}})
