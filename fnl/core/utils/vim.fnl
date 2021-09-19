(local {: last} (require :cljlib))
(local {: format} string)

(fn cmd! [s]
  (vim.cmd s))

(fn extcmd! [s]
  (let [res (vim.fn.execute (format "!%s" s))]
    (last (icollect [line (res:gmatch "[^\n\r]+")] line))))

{: cmd!
 : extcmd!}
