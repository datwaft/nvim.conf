(module core.utils.io)

(defn- double-quote [str]
  (string.format "\"%s\"" str))

(defn echo! [str]
  (vim.cmd (string.format "echom %s" (double-quote str)))
  nil)

(defn warn! [str]
  (vim.cmd (string.format "
                          echohl WarningMsg
                          echom %s
                          echohl None
                          " (double-quote str)))
  nil)

(defn err! [str]
  (vim.cmd (string.format "
                          echohl ErrorMsg
                          echom %s
                          echohl None
                          " (double-quote str)))
  nil)
