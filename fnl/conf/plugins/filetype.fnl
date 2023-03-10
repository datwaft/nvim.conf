(import-macros {: pack} :themis.pack.lazy)

[;; Fennel
 (pack "jaawerth/fennel.vim")
 ;; Hy
 (pack "hylang/vim-hy")
 ;; Guile
 {:url "https://gitlab.com/HiPhish/guile.vim.git"}
 ;; LaTeX
 (pack "lervag/vimtex" {:init #(do (import-macros {: let!} :themis.var)
                                 (let! vimtex_view_method "skim")
                                 (let! vimtex_compiler_latexmk {:options ["-shell-escape"
                                                                          "-verbose"
                                                                          "-file-line-error"
                                                                          "-synctex=1"
                                                                          "-interaction=nonstopmode"]}))})
 ;; General
 (pack "sheerun/vim-polyglot" {:init #(do (import-macros {: let!} :themis.var)
                                        (let! polyglot_disabled ["fennel"
                                                                 "autoindent" "sensible"
                                                                 "rnoweb"]))})]
