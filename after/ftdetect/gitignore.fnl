(import-macros {: autocmd!} :themis.event)
(import-macros {: local-set!} :themis.opt)

(autocmd! [BufNewFile BufRead] .prettierignore '(local-set! filetype :gitignore))
(autocmd! [BufNewFile BufRead] .eslintignore '(local-set! filetype :gitignore))
