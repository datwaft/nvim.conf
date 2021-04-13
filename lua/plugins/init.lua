-- ======================
-- PLUGINS INITIALIZATION
-- ======================
-- Created by datwaft <github.com/datwaft>

vim.cmd [[packadd packer.nvim]]

local nocode = function()
  return vim.fn.exists('g:vscode') == 0
end

local tmux = function()
  return vim.fn.exists('$TMUX') == 1
end

local kitty = function()
  return vim.fn.exists('$KITTY_WINDOW_ID') == 1
end

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
      cond = { nocode },
    }
  --------------
  -- Statusline
  --------------
    use {
      'datwaft/bubbly.nvim',
      config = require'plugins.statusline',
      branch = 'dev',
    }
  -------------
  -- Treesitter
  -------------
    use {
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require'plugins.treesitter',
        cond = { nocode },
      },
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = 'nvim-treesitter/nvim-treesitter',
        cond = { nocode },
      },
      {
        'windwp/nvim-ts-autotag',
        requires = 'nvim-treesitter/nvim-treesitter',
        cond = { nocode },
      },
    }
  -----------------------
  -- Substitution preview
  -----------------------
    use {
      'markonm/traces.vim',
      config = require'plugins.traces',
    }
  ------------------
  -- Color highlight
  ------------------
    use {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      config = require'plugins.hexokinase',
      cond = { nocode },
    }
  ---------------
  -- Indent lines
  ---------------
    use {
      'lukas-reineke/indent-blankline.nvim',
      branch = 'lua',
      config = require'plugins.indent_blankline',
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
    use { 'AndrewRadev/splitjoin.vim' }
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
      cond = { nocode },
    }
    -- Execute commands
    use {
      'lambdalisue/gina.vim',
      cond = { nocode },
    }
  -------------
  -- Nerd fonts
  -------------
    -- Nerd font support
    use {
      'lambdalisue/nerdfont.vim',
      cond = { nocode },
    }
    -- Colorize nerd font icons
    use {
      'lambdalisue/glyph-palette.vim',
      config = require'plugins.glyph-palette',
      cond = { nocode },
    }
  -------
  -- REPL
  -------
    use {
      'jpalardy/vim-slime',
      config = require'plugins.vim-slime',
      cond = { nocode },
    }
  -------
  -- Tmux
  -------
    use {
      'christoomey/vim-tmux-navigator',
      config = require'plugins.tmux-navigator',
      cond = { tmux, nocode },
    }
  --------
  -- Kitty
  --------
    use {
      'knubie/vim-kitty-navigator',
      cond = { kitty, nocode },
    }
  --------
  -- Emmet
  --------
    use {
      'mattn/emmet-vim',
      config = require'plugins.emmet',
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
      requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
      config = require'plugins.telescope',
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
        cond = { nocode },
      },
      {
        'lambdalisue/fern-git-status.vim',
        requires = { 'lambdalisue/fern.vim' },
        cond = { nocode },
      },
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        requires = { 'lambdalisue/fern.vim' },
        cond = { nocode },
      },
      {
        'lambdalisue/fern-hijack.vim',
        requires = { 'lambdalisue/fern.vim' },
        cond = { nocode },
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
      cond = { nocode },
    }
  ---------------
  -- Installation
  ---------------
    use {
      'anott03/nvim-lspinstall',
      cond = { nocode },
    }
  ---------
  -- Status
  ---------
    use {
      'nvim-lua/lsp-status.nvim',
      cond = { nocode },
    }
  -------------
  -- Completion
  -------------
    use {
      'hrsh7th/nvim-compe',
      config = require'plugins.nvim-compe',
      cond = { nocode },
    }
  ------------
  -- Aesthetic
  ------------
    use {
      'kosayoda/nvim-lightbulb',
      config = require'plugins.lightbulb',
      cond = { nocode },
    }
  ------------
  -- Signature
  ------------
    use {
      'ray-x/lsp_signature.nvim',
      config = require'plugins.lsp-signature',
      cond = { nocode },
    }
  -------------
  -- Extensions
  -------------
    use {
      'nvim-lua/lsp_extensions.nvim',
      config = require'plugins.lsp-extensions',
      cond = { nocode },
    }
  ----------
  -- Actions
  ----------
    use {
      'glepnir/lspsaga.nvim',
      config = require'plugins.lspsaga',
      cond = { nocode },
    }
  -----------
  -- Snippets
  -----------
    use {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'norcalli/snippets.nvim',
      cond = { nocode },
    }
  ------------------------------
  -- SQL Language Server support
  ------------------------------
    use {
      'nanotee/sqls.nvim',
      cond = { nocode },
    }
end)
