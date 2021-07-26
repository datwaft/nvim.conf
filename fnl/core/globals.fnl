(module core.globals
  {require {a aniseed.core
            clj lib.cljlib}})

(defn- import-all [tbl]
  "This function adds every key/value pair from a table to the global table
  using the same format in which fennel formats its compiled variable names"
  (each [key value (pairs tbl)]
    (let [key (if (string.match key "%W")
                (.. "__fnl_global__"
                    (key:gsub "." #(if (not (= nil (string.match $ "%w"))) $
                                     (string.format "_%x" (string.byte "?")))))
                key)]
      (tset _G key value))))

; Prints parameters in a readable format
(global dump (fn [...]
               (let [objects (vim.tbl_map vim.inspect [...])]
                 (print (unpack objects)))))

; Add aniseed core functions to globals
(import-all a.aniseed/locals)

; Use fennel cljlib as a standard library
(import-all clj)
