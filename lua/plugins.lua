-- PLUGINS.LUA
-- ===========
-- Created by: datwaft [github.com/datwaft]

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
-- Essential
-- =========
   -- Packer itself
   use {'wbthomason/packer.nvim', opt = true}
   -- Use Lua to configure vim
   use {'svermeulen/vimpeccable'}
-- Aesthetic
-- =========
   -- Colorscheme
   use {
      'bluz71/vim-nightfly-guicolors',
      config = require('plugins.colorscheme'),
   }
end)
