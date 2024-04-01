;; extends
;; vi:nospell:

;; \renewcommand
(new_command_definition) @nospell
;; \definecolor
(color_definition) @nospell
;; \lstset
((generic_command
   command: (command_name) @_command_name
   arg:
   (curly_group) @nospell)
 (#eq? @_command_name "\\lstset"))
;; \usefont
((generic_command
   command: (command_name) @_command_name
   arg:
   (curly_group
     (text) @nospell))
 (#eq? @_command_name "\\usefont"))
;; \begin{lstlisting}
(listing_environment) @nospell
;; \setcounter
((generic_command
   command: (command_name) @_command_name
   arg:
   (curly_group
     (text) @nospell))
 (#eq? @_command_name "\\setcounter"))
;; \newenvironment
(ERROR . "\\newenvironment" @nospell)
