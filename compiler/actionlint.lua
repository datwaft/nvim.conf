if vim.fn.exists("current_compiler") == 1 then return end
vim.g.current_compiler = "actionlint"

vim.bo.makeprg = "actionlint -oneline"
---@diagnostic disable-next-line: assign-type-mismatch
vim.bo.errorformat = { [[%f:%l:%c: %m]] }
