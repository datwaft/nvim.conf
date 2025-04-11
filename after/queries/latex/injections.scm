; extends

; \mintinline{<language>}{<code>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\mintinline")
  arg: (curly_group
    (text) @injection.language)
  (#offset! @injection.language 0 1 0 -1)
  arg: (curly_group
    (text) @injection.content)
  (#offset! @injection.content 0 1 0 -1))
