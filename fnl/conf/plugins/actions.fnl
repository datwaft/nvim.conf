(import-macros {: pack} :themis.pack.lazy)

[;; Comment
 (pack "echasnovski/mini.comment" {:config #((. (require :mini.comment) :setup))})
 ;; Surround
 (pack "echasnovski/mini.surround" {:config #((. (require :mini.surround) :setup))})
 ;; Split or join blocks of code
 (pack "Wansmer/treesj" {:dependencies ["nvim-treesitter/nvim-treesitter"]
                         :config true})
 ;; Edit language injection
 (pack "AckslD/nvim-FeMaco.lua" {:config true})]
