(local {: int?} (require :cljlib))
(local {: format} string)

(fn cmd! [s]
  "Execute ex command and capture the output."
  (vim.cmd s))

(fn extcmd! [s]
  "Execute external command and capture the output."
  (let [output (vim.fn.system s)]
    (if (not= output "") (output:sub 1 -2)
      nil)))

(fn ui? []
  (not= 0 (length (vim.api.nvim_list_uis))))

(fn has? [property]
  "Returns if vim has a property"
  (match (vim.fn.has property)
    1 true
    0 false
    _ nil))

(fn extract-highlight [name]
  (let [(ok? result) (pcall vim.api.nvim_get_hl_by_name name true)]
    (when ok? (collect [k v (pairs result)]
                       (values k (if (int? v) (format "#%06x" v)
                                   v))))))

{: cmd!
 : extcmd!
 : ui?
 : has?
 : extract-highlight}
