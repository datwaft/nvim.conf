[;; Fennel
 (pack "jaawerth/fennel.vim")
 ;; General
 (pack "sheerun/vim-polyglot"
       {:init #(let! polyglot_disabled ["fennel" "autoindent" "sensible"])})
 ]
