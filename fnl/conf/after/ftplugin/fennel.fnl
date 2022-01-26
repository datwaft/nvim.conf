(import-macros {: local-set!} :conf.macro.opt)

(local {: stdpath} vim.fn)

(local-set! nowrap)
(local-set! suffixesadd^ "/init.fnl")
(local-set! suffixesadd^ ".fnl")
(local-set! path^ (.. (stdpath "config") "/fnl"))
(local-set! includeexpr "substitute(v:fname,'\\.','/','g')")
