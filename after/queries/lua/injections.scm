;; extends

;; vim.opt.grepprg = "bash"
((assignment_statement
   (variable_list) @_variable_symbol
   (expression_list
     value:
       (string
         content: _ @injection.content)))
 (#set! injection.language "bash")
 (#eq? @_variable_symbol "vim.opt.grepprg"))
