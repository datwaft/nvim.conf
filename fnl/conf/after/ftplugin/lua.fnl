(import-macros {: local-set!} :themis.opt)

(local {: stdpath} vim.fn)

(local-set! suffixesadd^ "/init.lua")
(local-set! suffixesadd^ ".lua")
(local-set! includeexpr "substitute(v:fname,'\\\\.','/','g')")
