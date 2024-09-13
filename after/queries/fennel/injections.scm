;; extends

;; (set! grepprg "bash")
((list
  .
  call: (symbol) @_set
  .
  item: [(symbol) @_grepprg (string (string_content) @_grepprg)]
  .
  item: (string (string_content) @injection.content))
 (#set! injection.language "bash")
 (#eq? @_set "set!")
 (#eq? @_grepprg "grepprg"))

;; (autocmd! VimOpen * "vim")
((list
   call: (symbol) @call
   item: _
   item: _
   .
   item: (string (string_content) @injection.content))
 (#set! injection.language "vim")
 (#eq? @call "autocmd!"))
