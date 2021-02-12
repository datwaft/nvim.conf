-- ====================
-- INPUT/OUTPUT LIBRARY
-- ====================
-- Created by datwaft <github.com/datwaft>

local M = require'core.module'.new'utils.io'

-- Print message as a warning
M.warning = function(message)
   vim.cmd([[echohl WarningMsg]])
   vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
   vim.cmd([[echohl None]])
end

-- Print message as an error
M.error = function(message)
   vim.cmd([[echohl ErrorMsg]])
   vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
   vim.cmd([[echohl None]])
end

-- Replace termcodes in string
M.replace_termcodes = function(string)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
