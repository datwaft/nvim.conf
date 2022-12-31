(import-macros {: pack} :themis.pack.lazy)

[;; Indent
 "michaeljsmith/vim-indent-object"
 ;; CamelCase
 (pack "bkad/CamelCaseMotion"
       {:config (fn []
                  (import-macros {: map!} :themis.keybind)
                  (map! [nvo] "<leader>w" "<Plug>CamelCaseMotion_w")
                  (map! [nvo] "<leader>b" "<Plug>CamelCaseMotion_b")
                  (map! [nvo] "<leader>e" "<Plug>CamelCaseMotion_e")
                  (map! [xo] "i<leader>w" "<Plug>CamelCaseMotion_ie"))})
 ;; Around and inner
 (pack "echasnovski/mini.ai" {:config #(. (require :mini.ai) :setup)})
 ;; Whitespace
 "vim-utils/vim-space"]
