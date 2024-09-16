;; extends

;; {"@variable.member" <any>}
(table_pair
  key: (string) @variable.member)

;; (. <any> "@variable.member" ...)
(list
  call: (symbol) @_call
  (#eq? @_call ".")
  .
  item: (_)
  item: (string) @variable.member)

;; (: <any> "@function.method.call" <any>)
(list
  call: (symbol) @_call
  (#eq? @_call ":")
  .
  (_)
  .
  item: (string) @function.method.call)

;; (tset <any> "@variable.member" ... <any>)
(list
  call: (symbol) @_call
  (#eq? @_call "tset")
  .
  item: (_)
  .
  item: (string) @variable.member)

;; (map! [n] "<leader>f" "<cmd>echo Hello World<cr>" "@string.documentation.fennel")
;; (autocmd! VimOpen * "wincmd =" "@string.documentation.fennel")
(list
  call: (symbol) @_call
  (#any-of? @_call "map!" "autocmd!")
  .
  item: (_)
  item: (_)
  item: (_)
  item: (string) @string.documentation
  .)
