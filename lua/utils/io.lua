-- ====================
-- INPUT/OUTPUT LIBRARY
-- ====================
-- Created by datwaft <github.com/datwaft>

local M = require'core.module'.new { name = 'utils.io' }

-- Print message as a warning
M.warning = function(message)
  vim.cmd([[echohl WarningMsg]])
  vim.cmd(string.format([[echomsg "[CORE] [WARNING] %s"]],
    vim.fn.escape(message, "\"\\")))
  vim.cmd([[echohl None]])
end

-- Print raw message as a warning
M.raw_warning = function(message)
  vim.cmd([[echohl WarningMsg]])
  vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
  vim.cmd([[echohl None]])
end

-- Print message as an error
M.error = function(message)
  vim.cmd([[echohl ErrorMsg]])
  vim.cmd(string.format([[echomsg "[CORE] [ERROR] %s"]],
    vim.fn.escape(message, "\"\\")))
  vim.cmd([[echohl None]])
end

-- Print raw message as an error
M.raw_error = function(message)
  vim.cmd([[echohl ErrorMsg]])
  vim.cmd(string.format([[echomsg "%s"]], vim.fn.escape(message, "\"\\")))
  vim.cmd([[echohl None]])
end

return M
