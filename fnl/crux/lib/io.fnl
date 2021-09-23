(local {: cmd!} (require :crux.lib.vim))
(local {: format} string)

(fn double-quote [s]
  "Add double quotes at the beginning and end of the string."
  (format "\"%s\"" s))

(fn echo! [s]
  "Print a vim message without any format."
  (cmd! (format "echom %s" (double-quote s))))

(fn warn! [s]
  "Print a vim message with a warning format."
  (cmd! (format "echohl WarningMsg
                 echom %s
                 echohl None" (double-quote s))))

(fn err! [s]
  "Print a vim message with an error format."
  (cmd! (format "echohl ErrorMsg
                 echom %s
                 echohl None" (double-quote s))))

{: echo!
 : warn!
 : err!}
