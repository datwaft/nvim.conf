(import-macros {: pack} :themis.pack.lazy)

[;; Comment
 (pack "echasnovski/mini.comment" {:config #((. (require :mini.comment) :setup))})
 ;; Surround
 (pack "machakann/vim-sandwich")
 ;; Split or join blocks of code
 (pack "Wansmer/treesj" {:dependencies ["nvim-treesitter/nvim-treesitter"]
                         :config true})
 ;; Edit language injection
 (pack "AckslD/nvim-FeMaco.lua" {:config true})
 ;; Align text interactively
 (pack "echasnovski/mini.align" {:config #((. (require :mini.align) :setup))})]
