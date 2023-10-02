[;; Statusline
 (pack "nvim-lualine/lualine.nvim"
       {:dependencies ["nvim-tree/nvim-web-devicons"]
        :opts {:options {:globalstatus true
                         :theme "auto"
                         :disabled_filetypes {:winbar ["qf"]}}
               :winbar {:lualine_a [:location]
                        :lualine_b [:progress]
                        :lualine_c [:filename]}
               :inactive_winbar {:lualine_a [:location]
                                 :lualine_b [:progress]
                                 :lualine_c [:filename]}}})
 ;; Enhance vim.ui.select & vim.ui.input
 "stevearc/dressing.nvim"
 ;; Preview substitution
 (pack "markonm/traces.vim" {:init #(let! traces_abolish_integration 1)})
 ;; Preview ranges
 (pack "winston0410/range-highlight.nvim" {:dependencies ["winston0410/cmd-parser.nvim"]
                                           :config true})
 ;; Highlight color codes
 (pack "NvChad/nvim-colorizer.lua" {:opts {:user_default_options {:mode "virtualtext"
                                                                  :names false}}})
 ;; Indentation lines
 (pack "lukas-reineke/indent-blankline.nvim" {:main "ibl"
                                              :opts {:scope {:enabled false}}})
 ;; Make delimiters have different colors depending on nesting level
 "HiPhish/rainbow-delimiters.nvim"
 ;; Change theme based on system theme
 (pack "f-person/auto-dark-mode.nvim"
       {:opts {:set_dark_mode #(do
                                 (set! background :dark)
                                 (vim.cmd.colorscheme :catppuccin))
               :set_light_mode #(do
                                  (set! background :light)
                                  (vim.cmd.colorscheme :catppuccin))}})
 ]
