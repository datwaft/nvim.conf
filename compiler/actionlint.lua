if vim.fn.exists("current_compiler") == 1 then return end
vim.g.current_compiler = "actionlint"

vim.bo.makeprg = "actionlint -oneline"
vim.bo.errorformat = { [[%f:%l:%c: %m]] }
