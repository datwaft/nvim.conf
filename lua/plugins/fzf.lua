-- =================
-- FZF CONFIGURATION
-- =================
-- Created by datwaft [github.com/datwaft]

return function()
   if not pcall(require, 'vimp') then
      vim.cmd [[ echom 'Cannot load `vimp`' ]]
      return
   end
   -- Mappings
   vimp.nmap({'silent'}, '<C-p>', ':GFiles --cached --others --exclude-standard<cr>')
end
