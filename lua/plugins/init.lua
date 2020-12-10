-- ===========
-- PLUGINS.LUA
-- ===========
-- Created by: datwaft [github.com/datwaft]

vim.cmd [[ packadd packer.nvim ]]

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

return require'packer'.startup(function()
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
   use {
      'sainnhe/edge',
      config = require'plugins.colorscheme',
      as = 'colorscheme',
   }
   -- Statusline
   use { 'datwaft/bubbly.nvim', config = require'plugins.statusline', branch = 'dev' }
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
   use { 'unblevable/quick-scope', config = require'plugins.quickscope' }
   -- Color highlight
   use {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      config = require'plugins.hexokinase'
   }
   -- Smooth scrolling
   use { 'psliwka/vim-smoothie' }
-- ===================
-- Syntax highlighting
-- ===================
   -- Polyglot
   use { 'sheerun/vim-polyglot' }
   -- Prolog
   use { 'datwaft/prolog-syntax-vim' }
-- =================
-- Semantic analysis
-- =================
   -- Treesitter
   use {
      'nvim-treesitter/nvim-treesitter',
      config = require'plugins.treesitter',
      run = ':TSUpdate'
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
   -- LSP completion
   use {
      'neoclide/coc.nvim',
      branch = 'release',
      config = require'plugins.coc',
   }
-- ============
-- Text objects
-- ============
   -- More text objects
   use { 'wellle/targets.vim' }
   -- Indentation object
   use { 'michaeljsmith/vim-indent-object' }
   -- CamelCase and snake_case objects
   use { 'bkad/camelcasemotion', config = require'plugins.camelcasemotion' }
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
   -- Markdown preview
   use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
   }
-- ===============
-- File management
-- ===============
   -- Fuzzy Finder
   use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
   use { 'junegunn/fzf.vim' }
-- ===========
-- Integration
-- ===========
   -- Kitty integration
   use { 'knubie/vim-kitty-navigator' }
   -- REPL integration
   use { 'jpalardy/vim-slime', config = require'plugins.slime' }
end)

