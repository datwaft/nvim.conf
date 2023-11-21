[;; Autopairs
 (pack "altermo/ultimate-autopair.nvim" {:event [:InsertEnter :CmdlineEnter]
                                         :branch "v0.6"
                                         :config true})
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
 ;; Multiple 'commentstring' support
 "JoosepAlviste/nvim-ts-context-commentstring"
 ]
