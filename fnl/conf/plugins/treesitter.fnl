(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local treesitter (require :nvim-treesitter.configs))
  (treesitter.setup
    {:ensure_installed "all"
     :highlight {:enable true}
     :rainbow {:enable true
               :extended_mode true}
     :context_commentstring {:enable true}
     :indent {:enable false}
     :yati {:enable true}
     :refactor {:smart_rename {:enable true
                               :keymaps {:smart_rename "<localleader>rn"}}}}))

(pack "nvim-treesitter/nvim-treesitter" {:build ":TSUpdate"
                                         :dependencies ["p00f/nvim-ts-rainbow"
                                                        "JoosepAlviste/nvim-ts-context-commentstring"
                                                        "yioneko/nvim-yati"
                                                        "nvim-treesitter/nvim-treesitter-refactor"]
                                         : config})