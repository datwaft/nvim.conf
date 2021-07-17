(module core.globals
  {require {fun lib.fun
            a aniseed.core
            s aniseed.string}})

(defn- import-all [tbl]
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

; Add aniseed string functions to globals
(import-all s.aniseed/locals)

; Add aniseed core functions to globals
(import-all a.aniseed/locals)

; Add all functional lua functions to globals
(import-all fun)
