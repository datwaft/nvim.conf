(import-macros {: autocmd!} :themis.event)
(import-macros {: local-set!} :themis.opt)

(autocmd! [BufNewFile BufRead] .fennel-test '(local-set! filetype :fennel))
