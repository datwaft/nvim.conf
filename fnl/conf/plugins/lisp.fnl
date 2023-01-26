(import-macros {: pack} :themis.pack.lazy)

[;; Parentheses inference
 (pack "eraserhd/parinfer-rust" {:build "cargo build --release"
                                 :ft conf.lisp-filetypes})
 ;; Interactive evaluation
 (pack "Olical/conjure" {:ft conf.lisp-filetypes
                         :config #(do
                                    (import-macros {: let!} :themis.var)
                                    ;; Set client for scheme
                                    (let! conjure#filetype#scheme "conjure.client.guile.socket"))})
 ;; Clojure interactive evaluation
 (pack "clojure-vim/vim-jack-in" {:ft "clojure"
                                  :dependencies ["tpope/vim-dispatch"
                                                 "radenling/vim-dispatch-neovim"]})]
