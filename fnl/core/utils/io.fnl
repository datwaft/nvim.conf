(local {: cmd!} (require :core.utils.vim))
(local {: format} string)

(fn double-quote [s]
  (format "\"%s\"" s))

(fn echo! [s]
  (cmd! (format "echom %s" (double-quote s))))

(fn warn! [s]
  (cmd! (format "echohl WarningMsg
                 echom %s
                 echohl None" (double-quote s))))

(fn err! [s]
  (cmd! (format "echohl ErrorMsg
                 echom %s
                 echohl None" (double-quote s))))

{: echo!
 : warn!
 : err!}
