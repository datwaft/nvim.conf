(pack "nvim-treesitter/nvim-treesitter"
      {:build ":TSUpdate"
       :config #(let [treesitter (require :nvim-treesitter.configs)]
                  (treesitter.setup $2))
       :dependencies ["nvim-treesitter/nvim-treesitter-refactor"
                      "JoosepAlviste/nvim-ts-context-commentstring"
                      "andymass/vim-matchup"]
       :opts {:ensure_installed "all"
              :highlight {:enable true}
              :indent {:enable true}
              :format {:enable true}
              :refactor {:smart_rename {:enable true
                                        :keymaps {:smart_rename "<localleader>rn"}}}
              :context_commentstring {:enable true}
              :matchup {:enable true}}})
