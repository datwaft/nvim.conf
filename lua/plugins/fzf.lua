-- =================
-- FZF CONFIGURATION
-- =================
-- Created by datwaft [github.com/datwaft]

return function()
   if not require'utils.prequire''vimp' then
      require'utils.io'.warning'WARNING: cannot load `vimp`'
      return
   end
   -- Mappings
   vimp.nmap({'silent'}, '<C-p>', ':GFiles --cached --others --exclude-standard<cr>')
end
