vim.bo.path = vim.fn.stdpath("config") .. "/lua," .. vim.bo.path
vim.bo.suffixesadd = { ".lua", "/init.lua" }
vim.bo.includeexpr = "tr(v:fname,'.','/')"
