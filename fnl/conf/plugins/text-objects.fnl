(import-macros {: pack} :themis.pack)

["wellle/targets.vim"
 "michaeljsmith/vim-indent-object"
 (pack "bkad/CamelCaseMotion"
       {:config (fn []
                  (import-macros {: map!} :themis.keybind)
                  (map! [nvo] "<leader>w" "<Plug>CamelCaseMotion_w")
                  (map! [nvo] "<leader>b" "<Plug>CamelCaseMotion_b")
                  (map! [nvo] "<leader>e" "<Plug>CamelCaseMotion_e")
                  (map! [xo] "i<leader>w" "<Plug>CamelCaseMotion_ie"))})
 "vim-utils/vim-space"]
