vim.bo.path = vim.fn.stdpath("config") .. "/lua," .. vim.bo.path
---@diagnostic disable-next-line: assign-type-mismatch
vim.bo.suffixesadd = { ".lua", "/init.lua" }
vim.bo.includeexpr = "tr(v:fname,'.','/')"
