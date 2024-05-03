;; extends

;; {:variable.member something}
(table_pair
  key: (string) @variable.member)

;; (. something :variable.member :variable.member ...)
((list
   call: (symbol) @_dot
   .
   item: _
   item: (string) @variable.member)
 (#eq? @_dot "."))

;; (: something :function.method.call something)
((list
   call: (symbol) @_colon
   .
   _
   .
   item: (string) @function.method.call)
 (#eq? @_colon ":"))

;; (tset something :variable.member ... something)
((list
   call: (symbol) @_tset
   .
   item: _
   item: (string) @variable.member 
   item: _
   .)
 (#eq? @_tset "tset"))
