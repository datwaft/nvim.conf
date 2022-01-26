(import-macros {: local-set!} :conf.macro.opt)

(local {: stdpath} vim.fn)

(local-set! suffixesadd^ "/init.lua")
(local-set! suffixesadd^ ".lua")
(local-set! path^ (.. (stdpath "config") "/lua"))
(local-set! includeexpr "substitute(v:fname,'\\\\.','/','g')")
