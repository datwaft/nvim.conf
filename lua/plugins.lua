-- ===========
-- PLUGINS.LUA
-- ===========
-- Created by: datwaft [github.com/datwaft]

vim.cmd [[ packadd packer.nvim ]]

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

return require('packer').startup(function()
-- =========
-- Essential
-- =========
   -- Packer itself
   use { 'wbthomason/packer.nvim', opt = true }
   -- Use Lua to configure vim
   use { 'svermeulen/vimpeccable' }
-- =========
-- Aesthetic
-- =========
   -- Colorscheme
   use { 'bluz71/vim-nightfly-guicolors', config = require('plugins.colorscheme') }
   -- Status line
   use { 'itchyny/lightline.vim', config = require('plugins.lightline') }
   -- Improved search highlight
   use { 'markonm/traces.vim' }
   -- Developer icons
   use { 'kyazdani42/nvim-web-devicons' }
   use { 'lambdalisue/glyph-palette.vim' }
   -- Show marks
   use { 'kshenoy/vim-signature' }
   -- Show VCS changes
   use { 'mhinz/vim-signify' }
   -- Quick-scoping
   use { 'unblevable/quick-scope', config = require('plugins.quickscope') }
-- ===================
-- Syntax highlighting
-- ===================
   -- Polyglot
   use { 'sheerun/vim-polyglot' }
-- =================
-- Semantic analysis
-- =================
   -- Treesitter
   use { 
      'nvim-treesitter/nvim-treesitter',
      config = require('plugins.treesitter')
   }
   -- Treesitter refactor
   use {
      'nvim-treesitter/nvim-treesitter-refactor',
      requires = 'nvim-treesitter/nvim-treesitter'
   }
   -- Treesitter context
   use {
      'romgrk/nvim-treesitter-context',
      requires = 'nvim-treesitter/nvim-treesitter'
   }
-- ==========
-- Completion
-- ==========
   -- LSP autocompletion
   use {
      'neoclide/coc.nvim',
      branch = 'release',
      config = require('plugins.cocnvim'),
   }
-- ============
-- Text objects
-- ============
   -- More text objects
   use { 'wellle/targets.vim' }
   -- Indentation object
   use { 'michaeljsmith/vim-indent-object' }
   -- CamelCase and snake_case objects
   use { 'bkad/camelcasemotion', config = require('plugins.camelcasemotion') }
-- =======
-- Actions
-- =======
   -- Ability to comment
   use { 'tpope/vim-commentary' }
   -- Ability to surround
   use { 'machakann/vim-sandwich' }
   -- Easy swap in function
   use { 'machakann/vim-swap' }
   -- Exchange objects
   use { 'tommcdo/vim-exchange' }
-- ========
-- Commands
-- ========
   -- Undo tree
   use { 'mbbill/undotree' }
   -- Git management
   use { 'lambdalisue/gina.vim' }
   -- Subtitution with caps
   use { 'tpope/vim-abolish' }
-- ===============
-- File management
-- ===============
   -- Fuzzy Finder
   use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
   use { 'junegunn/fzf.vim' }
-- ===========
-- Integration
-- ===========
   -- Tmux integration
   use { 'christoomey/vim-tmux-navigator', config = require('plugins.tmuxnavigator') }
   -- REPL integration
   use { 'jpalardy/vim-slime', config = require('plugins.slime') }
end)
