[;; Fennel
 (pack "jaawerth/fennel.vim")
 ;; LaTeX
 (pack "lervag/vimtex"
       {:init #(do
                 (let! vimtex_view_method "skim")
                 (let! vimtex_compiler_latexmk {:options ["-shell-escape"
                                                          "-verbose"
                                                          "-file-line-error"
                                                          "-synctex=1"
                                                          "-interaction=nonstopmode"]}))})
 ;; General
 (pack "sheerun/vim-polyglot"
       {:init #(let! polyglot_disabled ["fennel" "autoindent" "sensible"])})
 ]
