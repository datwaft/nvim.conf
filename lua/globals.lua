-- =================
-- GLOBALS.LUA
-- =================
-- Created by: datwaft [github.com/datwaft]

_G.dump = function(...)
   local objects = vim.tbl_map(vim.inspect, {...})
   print(unpack(objects))
end
