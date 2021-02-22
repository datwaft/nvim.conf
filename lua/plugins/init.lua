-- ======================
-- PLUGINS INITIALIZATION
-- ======================
-- Created by datwaft <github.com/datwaft>

vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(function()
-- =========
-- Essential
-- =========
  -----------------
  -- Plugin manager
  -----------------
    use { 'wbthomason/packer.nvim', opt = true }
  --------------------------------------------------
  -- Auxiliar functions to use Lua for configuration
  --------------------------------------------------
    use { 'svermeulen/vimpeccable' }
-- =========
-- Aesthetic
-- =========
  --------------
  -- Colorscheme
  --------------
    use {
      'sainnhe/edge',
      config = require'plugins.colorscheme',
      as = 'colorscheme',
    }
  --------------
  -- Statusline
  --------------
    use {
      'datwaft/bubbly.nvim',
      config = require'plugins.statusline',
      branch = 'development',
    }
-- ===========
-- Integration
-- ===========
  ------
  -- Git
  ------
    -- Show changes
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = require'plugins.gitsigns',
    }
    -- Show blame
    use {
      'f-person/git-blame.nvim',
      config = require'plugins.git-blame'
    }
end)
