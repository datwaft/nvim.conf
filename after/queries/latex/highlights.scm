; extends

; \mintinline{<language>}{<code>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\mintinline")
  .
  arg: (curly_group) @nospell
  .
  arg: (curly_group) @nospell .)

; \texttt{<code>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\texttt")
  arg: (curly_group
    _ @nospell))

; \lstinline{<code>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\lstinline")
  arg: (curly_group
    _ @nospell))
