[;; Fennel
 (pack "jaawerth/fennel.vim")
 ;; LaTeX
 "lervag/vimtex"
 ;; General
 (pack "sheerun/vim-polyglot"
       {:init #(let! polyglot_disabled ["fennel" "autoindent" "sensible"])})
 ]
