(local {: cmd!} (require :core.utils.vim))

(fn double-quote [str]
  (string.format "\"%s\"" str))

(fn echo! [str]
  (cmd! (string.format "echom %s" (double-quote str))))

(fn warn! [str]
  (cmd! (string.format "
                       echohl WarningMsg
                       echom %s
                       echohl None
                       " (double-quote str))))

(fn err! [str]
  (cmd! (string.format "
                       echohl ErrorMsg
                       echom %s
                       echohl None
                       " (double-quote str))))

{: echo!
 : warn!
 : err!}
