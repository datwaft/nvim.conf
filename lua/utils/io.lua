-- =================
-- INPUT/OUPUT UTILS
-- =================
-- Created by: datwaft [github.com/datwaft]

local M = require'core.module'.new('utils.io')

M.warning = function(message)
   vim.cmd([[echohl WarningMsg]])
   vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
   vim.cmd([[echohl None]])
end

M.error = function(message)
   vim.cmd([[echohl ErrorMsg]])
   vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
   vim.cmd([[echohl None]])
end

return M
