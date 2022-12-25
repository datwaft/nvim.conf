(import-macros {: pack} :themis.pack.lazy)

[;; Comment
 (pack "numToStr/Comment.nvim" {:config true})
 ;; Surround
 "machakann/vim-sandwich"
 ;; Split or join blocks of code
 (pack "Wansmer/treesj" {:dependencies ["nvim-treesitter/nvim-treesitter"]
                         :config true})
 ;; Edit language injection
 (pack "AckslD/nvim-FeMaco.lua" {:config true})]
