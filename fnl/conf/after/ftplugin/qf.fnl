(import-macros {: buf-map!} :conf.macro.keybind)

(local {: line
        : getqflist
        : setqflist} vim.fn)
(local {:cmd cmd!} vim)
(local {: format} string)
(local {: remove} table)

(fn remove-item []
  (let [current-item (line ".")
        current-list (getqflist)
        new-list (doto current-list (remove current-item))]
    (setqflist new-list "r")))

(buf-map! [n] "<localleader>q" "<cmd>cclose<cr>"
          "close the quickfix list window")
(buf-map! [n] "dd" remove-item)
