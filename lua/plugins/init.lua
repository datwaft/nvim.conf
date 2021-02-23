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
  -------------------
  -- Syntax highlight
  -------------------
    use { 'sheerun/vim-polyglot' }
-- ============
-- Text objects
-- ============
  ---------------------------
  -- General-use text objects
  ---------------------------
    use { 'wellle/targets.vim' }
  --------------------------------
  -- Indentation level text object
  --------------------------------
    use { 'michaeljsmith/vim-indent-object' }
  ---------------------------------------
  -- CameCase and snake_case text objects
  ---------------------------------------
    use { 'bkad/camelcasemotion', config = require'plugins.camelcasemotion' }
-- =======
-- Actions
-- =======
  ----------
  -- Comment
  ----------
    use { 'b3nj5m1n/kommentary' }
  -----------
  -- Surround
  -----------
    use { 'machakann/vim-sandwich' }
-- ========
-- Commands
-- ========
  --------------------------
  -- Subversion and Coersion
  --------------------------
    use { 'tpope/vim-abolish' }
  -----------------
  -- Show undo tree
  -----------------
    use { 'mbbill/undotree' }
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
    -- Execute commands
    use { 'lambdalisue/gina.vim' }
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
  -------
  -- REPL
  -------
    use { 'jpalardy/vim-slime', config = require'plugins.vim-slime' }
  -------
  -- Tmux
  -------
    use {
      'christoomey/vim-tmux-navigator',
      config = require'plugins.tmux-navigator',
    }
  -------------------------
  -- Debug Adapter Protocol
  -------------------------
    use {
      {
        'mfussenegger/nvim-dap',
        config = require'plugins.dap'
      },
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'mfussenegger/nvim-dap-python' },
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
-- ================
-- Language Servers
-- ================
  ----------------
  -- Configuration
  ----------------
    use { 'neovim/nvim-lspconfig' }
  ---------------
  -- Installation
  ---------------
    use { 'anott03/nvim-lspinstall' }
  ---------
  -- Status
  ---------
    use { 'nvim-lua/lsp-status.nvim' }
  -------------
  -- Completion
  -------------
    use {
      'hrsh7th/nvim-compe',
      config = require'plugins.nvim-compe',
    }
  ----------
  -- Actions
  ----------
    use {
      'glepnir/lspsaga.nvim',
      config = require'plugins.lspsaga',
    }
  -----------
  -- Snippets
  -----------
    use {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'norcalli/snippets.nvim',
    }
  ------------
  -- Aesthetic
  ------------
    -- Show lightbulb for code actions
    use { 'kosayoda/nvim-lightbulb', config = require'plugins.lightbulb' }
end)
