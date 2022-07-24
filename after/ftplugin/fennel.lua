local _local_1_ = vim.fn
local stdpath = _local_1_["stdpath"]
vim.opt_local["wrap"] = false
do end (vim.opt_local.suffixesadd):prepend("/init.fnl")
do end (vim.opt_local.suffixesadd):prepend(".fnl")
do end (vim.opt_local)["includeexpr"] = "substitute(v:fname,'\\.','/','g')"
return nil