(module core.globals
  {require {a aniseed.core
            fennel conjure.aniseed.deps.fennel
            clj lib.cljlib}})

; Prints parameters in a readable format
(global dump (fn [...]
               (let [objects (vim.tbl_map vim.inspect [...])]
                 (print (unpack objects)))))

; Prints parameters in a readable format as lisp
(global view (fn [...]
               (let [objects (vim.tbl_map fennel.view [...])]
                 (print (unpack objects)))))
