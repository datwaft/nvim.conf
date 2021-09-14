(local {: last} (require :cljlib))

(fn cmd! [str]
  (vim.cmd str))

(fn extcmd! [str]
  (let [res (vim.fn.execute (string.format "!%s" str))]
    (last (icollect [line (res:gmatch "[^\n\r]+")] line))))

{: cmd!
 : extcmd!}
