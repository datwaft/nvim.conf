(fn config [plugin opts]
  (set! foldmethod :expr)
  (set! foldexpr "v:lua.vim.treesitter.foldexpr()")
  (set! foldtext "v:lua.vim.treesitter.foldtext()")
  (set! nofoldenable)
  (let [treesitter (require :nvim-treesitter.configs)]
    (treesitter.setup opts)))

(pack "nvim-treesitter/nvim-treesitter"
      {:build ":TSUpdate"
       : config
       :dependencies ["nvim-treesitter/nvim-treesitter-refactor"
                      "andymass/vim-matchup"]
       :opts {:ensure_installed "all"
              :highlight {:enable true
                          :disable [:latex]}
              :indent {:enable true}
              :format {:enable true}
              :refactor {:smart_rename {:enable true
                                        :keymaps {:smart_rename "<localleader>rn"}}}
              :matchup {:enable true}}})
