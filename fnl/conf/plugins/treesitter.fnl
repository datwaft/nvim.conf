(import-macros {: pack} :themis.pack.lazy)

(fn contains? [tbl val]
  (accumulate [is? false
               _ it (ipairs tbl)
               &until is?]
    (= it val)))

(fn config []
  (local treesitter (require :nvim-treesitter.configs))
  (local parsers (require :nvim-treesitter.parsers))
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
               :disable (icollect [_ language (ipairs (parsers.available_parsers))]
                          (when (not (contains? conf.lisp-filetypes language)) language))
               :extended_mode true}
     :matchup {:enable true}}))

(pack "nvim-treesitter/nvim-treesitter" {:build ":TSUpdate"
                                         :dependencies ["JoosepAlviste/nvim-ts-context-commentstring"
                                                        "yioneko/nvim-yati"
                                                        "nvim-treesitter/nvim-treesitter-refactor"
                                                        "nvim-treesitter/playground"
                                                        "mrjones2014/nvim-ts-rainbow"
                                                        "andymass/vim-matchup"]
                                         : config})
