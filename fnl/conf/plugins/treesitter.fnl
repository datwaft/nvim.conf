(import-macros {: pack} :themis.pack.lazy)

(fn contains? [tbl val]
  (accumulate [is? false
               _ it (ipairs tbl)
               &until is?]
    (= it val)))

(fn config []
  (local treesitter (require :nvim-treesitter.configs))
  (local parsers (require :nvim-treesitter.parsers))
  (local rainbow (require :ts-rainbow))

  (treesitter.setup
    {:ensure_installed "all"
     :highlight {:enable true
                 :disable [:latex :rnoweb]}
     :context_commentstring {:enable true}
     :indent {:enable false}
     :yati {:enable true}
     :refactor {:smart_rename {:enable true
                               :keymaps {:smart_rename "<localleader>rn"}}}
     :playground {:enable true}
     :query_linter {:enable true
                    :use_virtual_text true
                    :lint_events ["BufWrite" "CursorHold"]}
     :rainbow {:enable true
               :query "rainbow-parens"
               :strategy rainbow.strategy.global}
     :matchup {:enable true}}))

(pack "nvim-treesitter/nvim-treesitter" {:build ":TSUpdate"
                                         :dependencies ["JoosepAlviste/nvim-ts-context-commentstring"
                                                        "yioneko/nvim-yati"
                                                        "nvim-treesitter/nvim-treesitter-refactor"
                                                        "nvim-treesitter/playground"
                                                        "HiPhish/nvim-ts-rainbow2"
                                                        "andymass/vim-matchup"]
                                         : config})
