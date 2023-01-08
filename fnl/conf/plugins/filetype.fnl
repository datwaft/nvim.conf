(import-macros {: pack} :themis.pack.lazy)

[;; Fennel
 (pack "jaawerth/fennel.vim")
 ;; Hy
 (pack "hylang/vim-hy")
 ;; Guile
 {:url "git@gitlab.com:HiPhish/guile.vim.git"}
 ;; General
 (pack "sheerun/vim-polyglot" {:init #(do (import-macros {: let!} :themis.var)
                                        (let! polyglot_disabled ["fennel"
                                                                 "autoindent" "sensible"]))})]
