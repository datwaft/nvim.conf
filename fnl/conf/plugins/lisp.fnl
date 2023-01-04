(import-macros {: pack} :themis.pack.lazy)

[;; Parentheses inference
 (pack "gpanders/nvim-parinfer" {:ft conf.lisp-filetypes})
 ;; Interactive evaluation
 (pack "Olical/conjure" {:ft conf.lisp-filetypes})
 ;; Clojure interactive evaluation
 (pack "clojure-vim/vim-jack-in" {:ft "clojure"
                                  :dependencies ["tpope/vim-dispatch"
                                                 "radenling/vim-dispatch-neovim"]})]
