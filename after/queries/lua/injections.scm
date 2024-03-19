;; extends

;; vim.filetype.add({ pattern = { ["luap"] = "filetype" } })
((function_call
  name: (_) @_filetypeadd_identifier
  arguments:
    (arguments
      (table_constructor
        (field
          name: (_) @_pattern_key
          value:
            (table_constructor
              (field
                name:
                  (string
                    content: _ @injection.content)))))))
  (#set! injection.language "luap")
  (#eq? @_filetypeadd_identifier "vim.filetype.add")
  (#eq? @_pattern_key "pattern"))
