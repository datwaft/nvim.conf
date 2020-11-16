-- PLUGINS.MOON
-- ============
-- Created by: datwaft [github.com/datwaft]

return require'packer'.startup ->
-- Important plugins
-- =================
   -- Package manager
   use {'wbthomason/packer.nvim', opt: true}
   -- Use Lua to configure neovim
   use {'svermeulen/vimpeccable'}
   -- Use MoonScript as Lua
   use {'svermeulen/nvim-moonmaker'}
-- Syntax highlight
-- ================
   use {'leafo/moonscript-vim'}
