-- ===========================
-- GLOBAL VARIABLE DECLARATION
-- ===========================
-- Created by datwaft <github.com/datwaft>

return function()

   -- Prints parameters in a readable format
   _G.dump = function(...)
      local objects = vim.tbl_map(vim.inspect, {...})
      print(unpack(objects))
   end

end
