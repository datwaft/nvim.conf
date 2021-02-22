-- ======================
-- PLUGINS INITIALIZATION
-- ======================
-- Created by datwaft <github.com/datwaft>

vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(function()
-- =========
-- Essential
-- =========
  -- Plugin manager
  use { 'wbthomason/packer.nvim', opt = true }
  -- Auxiliar functions to use Lua for configuration
  use { 'svermeulen/vimpeccable' }
-- =========
-- Aesthetic
-- =========
  -- Colorscheme
  use {
    'sainnhe/edge',
    config = require'plugins.colorscheme',
    as = 'colorscheme',
  }
  -- Statusline
  use {
    'datwaft/bubbly.nvim',
    config = require'plugins.statusline',
    branch = 'development',
  }
end)
