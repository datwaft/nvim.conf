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

; \WarningFilter{<package>}{<warning>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\WarningFilter")
  arg: (curly_group
    _ @nospell)
  arg: (curly_group
    _ @nospell))

; \setmainfont{<file>}
; \setmathfont{<file>}
; \setCJKmainfont{<file>}
; \setCJKsansfont{<file>}
; \setCJKmonofont{<file>}
(generic_command
  command: (command_name) @command
  (#any-of? @command
    "\\setmainfont" "\\setmathfont" "\\setCJKmainfont" "\\setCJKsansfont" "\\setCJKmonofont")
  arg: (curly_group
    _ @nospell @string.special.path))

; \newtcolorbox{<name>}{<config>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\newtcolorbox")
  arg: (curly_group
    _ @nospell)
  arg: (curly_group
    _ @nospell))

; \email{<name>}
(generic_command
  command: (command_name) @command
  (#eq? @command "\\email")
  arg: (curly_group
    _ @nospell))
