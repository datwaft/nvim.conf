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

-- create a duplicate of a table
M.copytable = function(table)
   local result = {}
   for k,v in pairs(table) do
       result[k] = v
   end
   return result
end

return M
