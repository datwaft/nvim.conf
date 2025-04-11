; extends

; \mintinline{<language>}{<code>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\mintinline")
  .
  arg: (curly_group) @nospell
  .
  arg: (curly_group) @nospell .)
