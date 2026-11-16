vim.opt_local.path:prepend(vim.fn.stdpath("config") .. "/lua")
---@diagnostic disable-next-line: param-type-mismatch lists are supported for `:prepend`
vim.opt_local.suffixesadd:prepend({ ".lua", "/init.lua" })
vim.bo.includeexpr = "tr(v:fname,'.','/')"
