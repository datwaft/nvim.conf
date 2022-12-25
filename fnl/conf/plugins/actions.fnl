(import-macros {: pack} :themis.pack)

[(pack "numToStr/Comment.nvim" {:config #(let [{: setup} (require "Comment")] (setup))})
 "machakann/vim-sandwich"
 (pack "Wansmer/treesj" {:dependencies ["nvim-treesitter/nvim-treesitter"]
                         :config #(let [{: setup} (require "treesj")] (setup))})
 (pack "AckslD/nvim-FeMaco.lua" {:config #(let [{: setup} (require "femaco")] (setup))})]
