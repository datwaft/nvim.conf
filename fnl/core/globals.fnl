(module core.globals
  {require {fun lib.fun
            a aniseed.core
            s aniseed.string}})

; Prints parameters in a readable format
(global dump (fn [...]
               (let [objects (vim.tbl_map vim.inspect [...])]
                 (print (unpack objects)))))

; Add aniseed string functions to globals
(each [key val (pairs s)]
  (tset _G key val))
(global blank? s.blank?)

; Add aniseed core functions to globals
(each [key val (pairs a)]
  (tset _G key val))
(global string? a.string?)
(global nil? a.nil?)
(global table? a.table?)
(global empty? a.empty?)
(global even? a.even?)
(global odd? a.odd?)
(global kv-pairs a.kv-pairs)
(global run! a.run!)
(global map-indexed a.map-indexed)
(global pr-str a.pr-str)
(global merge! a.merge!)
(global select-keys a.select-keys)
(global get-in a.get-in)
(global assoc-in a.assoc-in)
(global update-in a.update-in)

; Add all functional lua functions to globals
(each [key val (pairs fun)]
  (tset _G key val))
