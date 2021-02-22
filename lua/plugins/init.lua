-- ======================
-- PLUGINS INITIALIZATION
-- ======================
-- Created by datwaft <github.com/datwaft>

local packer_install_path = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   vim.cmd('!git clone https://github.com/wbthomason/packer.nvim'..install_path)
end

vim.cmd [[packadd packer.nvim]]

return require'packer'.startup(function()
-- =========
-- Essential
-- =========
   -- Plugin manager
   use { 'wbthomason/packer.nvim', opt = true }
   -- Auxiliar functions to use Lua for configuration
   use { 'svermeulen/vimpeccable' }
end)
