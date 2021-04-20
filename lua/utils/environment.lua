-- ===================
-- ENVIRONMENT LIBRARY
-- ===================
-- Created by datwaft <github.com/datwaft>

local M = require'core.module'.new { name = 'utils.io' }

-- Return true if neovim is running on Windows
---@return boolean
function M.isWindows()
  return vim.fn.has('win32') == 1 or
    vim.fn.has('win64') == 1 or
    vim.fn.has('win16') == 1
end

return M
