(import-macros {: pack} :themis.pack.lazy)

[;; Fennel
 (pack "jaawerth/fennel.vim" {:ft "fennel"})
 ;; Hy
 (pack "hylang/vim-hy" {:ft "hy"})
 ;; General
 (pack "sheerun/vim-polyglot" {:init #(do (import-macros {: let!} :themis.var)
                                        (let! polyglot_disabled ["fennel"
                                                                 "autoindent" "sensible"]))})]
