(local {: cmd!} (require :crux.lib.vim))
(local {: format
        : sub} string)

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

(fn paste! [s]
  "Uploads string to a Paste server returning the URL."
  (let [tmp-file (vim.fn.tempname)]
    (vim.fn.writefile [s] tmp-file)
    (->
      (vim.fn.system (vim.fn.printf "cat %s | curl -sF 'f:1=<-' ix.io" tmp-file))
      (sub 1 -2))))

(fn set-clipboard! [s]
  "Set register '+' as the string passed as a parameter."
  (vim.fn.setreg "+" s))

{: echo!
 : warn!
 : err!
 : paste!
 : set-clipboard!}
