[;; Paredit for Clojure
 (pack "julienvincent/nvim-paredit" {:config true})
 ;; Paredit for Fennel
 (pack "julienvincent/nvim-paredit-fennel" {:config true
                                            :ft [:fennel]
                                            :dependencies ["julienvincent/nvim-paredit"]})
 ;; Toggle comments
 (pack "echasnovski/mini.comment" {:config true})
 ;; Surround operators
 (pack "machakann/vim-sandwich")
 ;; Subversion and coercion
 "tpope/vim-abolish"
 ;; Undo-tree
 "mbbill/undotree"
 ;; Indent text object
 "michaeljsmith/vim-indent-object"
 ;; Camelcase text object
 (pack "bkad/CamelCaseMotion"
       {:config #(do
                   (map! [nvo] "<leader>w" "<Plug>CamelCaseMotion_w")
                   (map! [nvo] "<leader>b" "<Plug>CamelCaseMotion_b")
                   (map! [nvo] "<leader>e" "<Plug>CamelCaseMotion_e")
                   (map! [xo] "i<leader>w" "<Plug>CamelCaseMotion_ie"))})
 ;; Around and inner text objects
 (pack "echasnovski/mini.ai"
       {:opts {:mappings {:around_last ""
                          :inside_last ""}}})
 ;; Space text objects
 "vim-utils/vim-space"
 ]
