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
  -------------
  -- Treesitter
  -------------
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = require'plugins.treesitter',
    }
  -----------------------
  -- Substitution preview
  -----------------------
    use { 'markonm/traces.vim' }
  ------------------
  -- Color highlight
  ------------------
    use {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      config = require'plugins.hexokinase',
    }
-- =======
-- Actions
-- =======
  ----------
  -- Comment
  ----------
    use { 'b3nj5m1n/kommentary' }
-- ========
-- Commands
-- ========
  --------------------------
  -- Subversion and Coersion
  --------------------------
    use { 'tpope/vim-abolish' }
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
  -------
  -- Glow
  -------
    -- Markdown preview
    use {
      'npxbr/glow.nvim',
      run = ':GlowInstall',
      config = require'plugins.glow',
    }
  -------------
  -- Nerd fonts
  -------------
    -- Nerd font support
    use { 'lambdalisue/nerdfont.vim' }
    -- Colorize nerd font icons
    use {
      'lambdalisue/glyph-palette.vim',
      config = require'plugins.glyph-palette',
    }
-- =====================
-- Files and directories
-- =====================
  ---------------
  -- Fuzzy Finder
  ---------------
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = require'plugins.telescope',
    }
  ----------------
  -- File explorer
  ----------------
    use {
      {
        'lambdalisue/fern.vim',
        requires = { 'antoinemadec/FixCursorHold.nvim' },
        config = require'plugins.file-explorer',
      },
      { 'lambdalisue/fern-git-status.vim' },
      { 'lambdalisue/fern-renderer-nerdfont.vim' },
      { 'lambdalisue/fern-hijack.vim' },
    }
end)
