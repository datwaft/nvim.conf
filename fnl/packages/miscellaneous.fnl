[;; Autopairs
 (pack "cohama/lexima.vim" {:init #(let! lexima_enable_basic_rules 1)})
 ;; Discover mappings
 (pack "folke/which-key.nvim" {:config true})
 ;; Create directories when saving if necessary
 "jghauser/mkdir.nvim"
 ;; Enhanced sorting
 (pack "sQVe/sort.nvim" {:config true})
 ;; Sync spell files
 "micarmst/vim-spellsync"
 ;; Never invalidate undo files
 (pack "kevinhwang91/nvim-fundo" {:build #(let [fundo (require :fundo)] (fundo.install))
                                  :dependencies ["kevinhwang91/promise-async"]
                                  :config true})
 ;; Better parentheses match
 "andymass/vim-matchup"
 ]
