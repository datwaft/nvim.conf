(fn cmd! [...] (vim.cmd ...))
(local {: format
        : sub} string)

(fn str? [x]
  (= :string (type x)))

(lambda double-quote [s]
  "Add double quotes at the beginning and end of the string."
  (assert (str? s) "expected string for s")
  (format "\"%s\"" s))

(lambda echo! [s]
  "Print a vim message without any format."
  (cmd! (format "echom %s" (double-quote s))))

(lambda warn! [s]
  "Print a vim message with a warning format."
  (cmd! (format "echohl WarningMsg
                 echom %s
                 echohl None" (double-quote s))))

(lambda err! [s]
  "Print a vim message with an error format."
  (cmd! (format "echohl ErrorMsg
                 echom %s
                 echohl None" (double-quote s))))

{: echo!
 : warn!
 : err!}
