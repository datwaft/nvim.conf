;; extends

;; (set! grepprg "bash")
(list
  .
  call: (symbol) @_call
  (#eq? @_call "set!")
  .
  item: [(symbol) @_grepprg (string (string_content) @_grepprg)]
  (#eq? @_grepprg "grepprg")
  .
  item: (string
          (string_content) @injection.content
          (#set! injection.language "bash")))

;; (autocmd! VimOpen * "vim")
(list
  call: (symbol) @_call
  (#eq? @_call "autocmd!")
  item: (_)
  item: (_)
  .
  item: (string
          (string_content) @injection.content
          (#set! injection.language "vim")))
