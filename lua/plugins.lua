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
   use {
      'bluz71/vim-nightfly-guicolors',
      config = require('plugins.colorscheme'),
   }
   -- Status line
   use {
      'itchyny/lightline.vim',
      config = require('plugins.lightline'),
   }
-- =====================
-- Semantic highlighting
-- =====================
   -- Treesitter
   use { 'nvim-treesitter/nvim-treesitter', config = require('plugins.treesitter') }
   -- Treesitter refactor
   use { 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter' }
   -- Treesitter context
   use { 'romgrk/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter' }
-- ==========
-- Completion
-- ==========
   -- LSP autocompletion
   use {
      'neoclide/coc.nvim',
      branch = 'release',
      config = require('plugins.cocnvim'),
   }
end)
