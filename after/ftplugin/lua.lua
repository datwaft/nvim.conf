vim.opt_local.path:prepend(vim.fn.stdpath("config") .. "/lua")
vim.opt_local.suffixesadd:prepend({ ".lua", "/init.lua" })
vim.bo.includeexpr = "tr(v:fname,'.','/')"
