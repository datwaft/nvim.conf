if vim.fn.exists("current_compiler") == 1 then return end
vim.g.current_compiler = "actionlint"

vim.opt_local.makeprg = "actionlint -oneline"
vim.opt_local.errorformat = { [[%f:%l:%c: %m]] }
