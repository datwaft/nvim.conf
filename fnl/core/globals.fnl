(module core.globals)

; Prints parameters in a readable format
(tset _G :dump (fn [...]
                (let [objects (vim.tbl_map vim.inspect [...])]
                  (print (unpack objects)))))
