(import-macros {: pack} :themis.pack.lazy)

[;; Keybind discoverability
 (pack "folke/which-key.nvim" {:config true})
 ;; Create directories when necessary
 "jghauser/mkdir.nvim"
 ;; Sorting
 (pack "sQVe/sort.nvim" {:config true})
 ;; Sync spell files
 "micarmst/vim-spellsync"
 ;; Pairs matching
 (pack "andymass/vim-matchup" {:init #(do (import-macros {: let!} :themis.var)
                                        (let! matchup_matchparen_offscreen {:method "popup"}))})
 ;; Support OSC52 on yank to system clipboard
 (pack "ojroques/nvim-osc52" {:config #(do (import-macros {: augroup!
                                                           : clear!
                                                           : autocmd!} :themis.event)
                                         (local osc52 (require :osc52))
                                         (osc52.setup {:silent true})
                                         (augroup! osc52-system-clipboard
                                           (clear!)
                                           (autocmd! TextYankPost * #(if (= vim.v.event.regname "+")
                                                                       (osc52.copy_register "+")
                                                                       (= vim.v.event.regname "*")
                                                                       (osc52.copy_register "*")))))})]
