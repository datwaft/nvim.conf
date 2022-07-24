local _local_1_ = vim.fn
local stdpath = _local_1_["stdpath"]
do end (vim.opt_local.suffixesadd):prepend("/init.lua")
do end (vim.opt_local.suffixesadd):prepend(".lua")
do end (vim.opt_local)["includeexpr"] = "substitute(v:fname,'\\\\.','/','g')"
return nil