-- =================
-- UTILITIES FOR LUA
-- =================
-- Created by datwaft [github.com/datwaft]

-- prerequire a package
local function prerequire(...)
   local status, lib = pcall(require, ...)
   if status then return lib end
   return nil
end

-- convert word to title case
local function titlecase(str)
   return str:sub(1,1):upper() .. str:sub(2)
end

-- create a duplicate of a table
local function copytable(table)
   local result = {}
   for k,v in pairs(table) do
       result[k] = v
   end
   return result
end

-- return string for syntax highlight
local function highlight(name, foreground, background, special)
   local command = 'highlight '
   command = command .. name .. ' '
   command = command .. 'guifg=' .. foreground .. ' '
   command = command .. 'guibg=' .. background .. ' '
   if special then
      command = command .. 'gui=' .. special .. ' '
   end
   return command
end

return {
   prerequire = prerequire,
   titlecase = titlecase,
   copytable = copytable,
   highlight = highlight
}
