-- =================
-- UTILITIES FOR LUA
-- =================
-- Created by datwaft [github.com/datwaft]

-- preamble
local M = {}

-- prerequire a package
M.prerequire = function(...)
   local status, lib = pcall(require, ...)
   if status then return lib end
   return nil
end

return M
