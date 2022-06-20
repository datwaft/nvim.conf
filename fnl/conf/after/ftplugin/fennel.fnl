(import-macros {: local-set!} :themis.opt)

(local {: stdpath} vim.fn)

(local-set! nowrap)
(local-set! suffixesadd^ "/init.fnl")
(local-set! suffixesadd^ ".fnl")
(local-set! includeexpr "substitute(v:fname,'\\.','/','g')")
