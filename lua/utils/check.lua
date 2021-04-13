-- ================
-- CHECKING LIBRARY
-- ================
-- Created by datwaft <github.com/datwaft>

local M = require'core.module'.new { name = 'utils.check' }

----------
-- VS Code
----------

M.code = function()
  return vim.fn.exists('g:vscode') == 1
end

M.nocode = function()
  return not M.code()
end

-------
-- TMUX
-------

M.tmux = function()
  return vim.fn.exists('$TMUX') == 1
end

--------
-- Kitty
--------

M.kitty = function()
  return vim.fn.exists('$KITTY_WINDOW_ID') == 1
end

return M
