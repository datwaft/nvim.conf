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
      branch = 'dev',
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
  ---------------
  -- Indent lines
  ---------------
    use {
      'lukas-reineke/indent-blankline.nvim',
      branch = 'lua',
      config = require'plugins.indent_blankline'
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
      }
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
    }
    -- Execute commands
    use { 'lambdalisue/gina.vim' }
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
      cond = function() return vim.fn.exists('$TMUX') end,
    }
  --------
  -- Kitty
  --------
    use {
      'knubie/vim-kitty-navigator',
      cond = function() return vim.fn.exists('$KITTY_WINDOW_ID') end,
    }
  --------
  -- Emmet
  --------
    use {
      'mattn/emmet-vim',
      config = require'plugins.emmet',
    }
  ----------------------------
  -- Treesitter comment string
  ----------------------------
    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = {
        require'nvim-treesitter.configs'.setup {
          context_commentstring = {
            enable = true
          }
        }
      }
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
  ------------
  -- Aesthetic
  ------------
    use {
      'kosayoda/nvim-lightbulb',
      config = require'plugins.lightbulb',
    }
  ------------
  -- Signature
  ------------
    use {
      'ray-x/lsp_signature.nvim',
      config = function() require'lsp_signature'.on_attach() end
    }
  -------------
  -- Extensions
  -------------
    use {
      'nvim-lua/lsp_extensions.nvim',
      config = require'plugins.lsp-extensions'
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
  ------------------------------
  -- SQL Language Server support
  ------------------------------
    use { 'nanotee/sqls.nvim' }
end)
