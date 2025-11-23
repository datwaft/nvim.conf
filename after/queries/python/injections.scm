; extends

; query = ""
(assignment
  left: (identifier) @_variable_name
  (#eq? @_variable_name "query")
  right: (string
    (string_content) @injection.content)
  (#set! injection.language "sql"))
