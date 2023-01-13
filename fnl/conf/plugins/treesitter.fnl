(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local treesitter (require :nvim-treesitter.configs))
  (treesitter.setup
    {:ensure_installed "all"
     :highlight {:enable true}
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
               :extended_mode true}}))

(pack "nvim-treesitter/nvim-treesitter" {:build ":TSUpdate"
                                         :dependencies ["JoosepAlviste/nvim-ts-context-commentstring"
                                                        "yioneko/nvim-yati"
                                                        "nvim-treesitter/nvim-treesitter-refactor"
                                                        "nvim-treesitter/playground"
                                                        "mrjones2014/nvim-ts-rainbow"]
                                         : config})
