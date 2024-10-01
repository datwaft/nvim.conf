; extends

; (vim.filetype.add {:pattern {"<luap injection>" "filetype"}})
(list
  call: (multi_symbol
    base: (symbol_fragment) @_vim
    (#eq? @_vim "vim")
    member: (symbol_fragment) @_filetype
    (#eq? @_filetype "filetype")
    member: (symbol_fragment) @_add
    (#eq? @_add "add"))
  item: (table
    (table_pair
      key: (string
        (string_content) @_key)
      (#eq? @_key "pattern")
      value: (table
        (table_pair
          key: (string
            (string_content) @injection.content)
          (#set! injection.language "luap"))))))

; (set! grepprg "bash")
(list
  .
  call: (symbol) @_call
  (#eq? @_call "set!")
  .
  item: [
    (symbol) @_grepprg
    (string
      (string_content) @_grepprg)
  ]
  (#eq? @_grepprg "grepprg")
  .
  item: (string
    (string_content) @injection.content
    (#set! injection.language "bash")))

; (autocmd! VimOpen * "vim")
(list
  call: (symbol) @_call
  (#eq? @_call "autocmd!")
  item: (_)
  item: (_)
  .
  item: (string
    (string_content) @injection.content
    (#set! injection.language "vim")))
