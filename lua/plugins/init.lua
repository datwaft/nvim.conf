-- ======================
-- PLUGINS INITIALIZATION
-- ======================
-- Created by datwaft <github.com/datwaft>

vim.cmd [[packadd packer.nvim]]

local nocode = require'utils.check'.nocode
local tmux = require'utils.check'.tmux
local kitty = require'utils.check'.kitty

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
      opt = true,
      cond = { nocode },
    }
  --------------
  -- Statusline
  --------------
    use {
      'datwaft/bubbly.nvim',
      config = require'plugins.statusline',
      branch = 'dev',
      opt = true,
      cond = { nocode },
    }
  -------------
  -- Treesitter
  -------------
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = require'plugins.treesitter',
      opt = true,
      cond = { nocode },
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
      opt = true,
      cond = { nocode },
    }
  ---------------
  -- Indent lines
  ---------------
    use {
      'lukas-reineke/indent-blankline.nvim',
      branch = 'lua',
      config = require'plugins.indent_blankline',
      opt = true,
      cond = { nocode },
    }
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
  -------------------------
  -- Whitespace text object
  -------------------------
    use { 'vim-utils/vim-space' }
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
  --------------
  -- Split lines
  --------------
    use {
      { 'sgur/vim-textobj-parameter', requires = 'kana/vim-textobj-user' },
      {
        'AckslD/nvim-revJ.lua',
        requires = { 'sgur/vim-textobj-parameter' },
        config = require'plugins.revj',
      },
    }
  ----------------------------------
  -- Increment and decrement numbers
  ----------------------------------
    use {
      'zegervdv/nrpattern.nvim',
      config = require'plugins.nrpattern',
      requires = { 'tpope/vim-repeat' }
    }
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
      opt = true,
      cond = { nocode },
    }
    -- Execute commands
    use {
      'lambdalisue/gina.vim',
      opt = true,
      cond = { nocode },
    }
  -------------
  -- Nerd fonts
  -------------
    -- Nerd font support
    use {
      'lambdalisue/nerdfont.vim',
      opt = true,
      cond = { nocode },
    }
    -- Colorize nerd font icons
    use {
      'lambdalisue/glyph-palette.vim',
      config = require'plugins.glyph-palette',
      opt = true,
      cond = { nocode },
    }
  -------
  -- REPL
  -------
    use {
      'jpalardy/vim-slime',
      config = require'plugins.vim-slime',
      opt = true,
      cond = { nocode },
    }
  -------
  -- Tmux
  -------
    use {
      'christoomey/vim-tmux-navigator',
      config = require'plugins.tmux-navigator',
      opt = true,
      cond = { tmux, nocode },
    }
  --------
  -- Kitty
  --------
    use {
      'knubie/vim-kitty-navigator',
      opt = true,
      cond = { kitty, nocode },
    }
  --------
  -- Emmet
  --------
    use {
      'mattn/emmet-vim',
      config = require'plugins.emmet',
      opt = true,
      cond = { nocode },
    }
  ----------------------------
  -- Treesitter comment string
  ----------------------------
    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      requires = 'nvim-treesitter/nvim-treesitter',
      opt = true,
      cond = { nocode },
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
      opt = true,
      cond = { nocode },
    }
  ----------------
  -- File explorer
  ----------------
    use {
      {
        'lambdalisue/fern.vim',
        requires = { 'antoinemadec/FixCursorHold.nvim' },
        config = require'plugins.file-explorer',
        opt = true,
        cond = { nocode },
      },
      {
        'lambdalisue/fern-git-status.vim',
        opt = true,
        after = { 'lambdalisue/fern.vim' },
      },
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        opt = true,
        after = { 'lambdalisue/fern.vim' },
      },
      {
        'lambdalisue/fern-hijack.vim',
        opt = true,
        after = { 'lambdalisue/fern.vim' },
      },
    }
-- ================
-- Language Servers
-- ================
  ----------------
  -- Configuration
  ----------------
    use {
      'neovim/nvim-lspconfig',
      opt = true,
      cond = { nocode },
    }
  ---------------
  -- Installation
  ---------------
    use {
      'anott03/nvim-lspinstall',
      opt = true,
      cond = { nocode },
    }
  ---------
  -- Status
  ---------
    use {
      'nvim-lua/lsp-status.nvim',
      opt = true,
      cond = { nocode },
    }
  -------------
  -- Completion
  -------------
    use {
      'hrsh7th/nvim-compe',
      config = require'plugins.nvim-compe',
      opt = true,
      cond = { nocode },
    }
  ------------
  -- Aesthetic
  ------------
    use {
      'kosayoda/nvim-lightbulb',
      config = require'plugins.lightbulb',
      opt = true,
      cond = { nocode },
    }
  ------------
  -- Signature
  ------------
    use {
      'ray-x/lsp_signature.nvim',
      config = function() require'lsp_signature'.on_attach() end,
      opt = true,
      cond = { nocode },
    }
  -------------
  -- Extensions
  -------------
    use {
      'nvim-lua/lsp_extensions.nvim',
      config = require'plugins.lsp-extensions',
      opt = true,
      cond = { nocode },
    }
  ----------
  -- Actions
  ----------
    use {
      'glepnir/lspsaga.nvim',
      config = require'plugins.lspsaga',
      opt = true,
      cond = { nocode },
    }
  -----------
  -- Snippets
  -----------
    use {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'norcalli/snippets.nvim',
      opt = true,
      cond = { nocode },
    }
  ------------------------------
  -- SQL Language Server support
  ------------------------------
    use {
      'nanotee/sqls.nvim',
      opt = true,
      cond = { nocode },
    }
end)
