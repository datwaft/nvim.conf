-- ================
-- AUTOCMD FUNCTION
-- ================
-- Created by datwaft <github.com/datwaft>

local io = require'utils.io'

-- Auxiliar function that translates a event list to a string
-- e.g.
-- { 'Event1', 'Event2' } => 'Event1,Event2'
local function processEvents(events)
   local result = ''
   for i, e in ipairs(events) do
      result = result..e
      if i ~= #events then
         result = result..','
      end
   end
   return result
end

-- Auxiliar function that translates command to string with potential side-effects
local function processCommand(command)
   if type(command) == 'string' then
      return command
   end
   _G[command.name] = command.command
   return 'call v:lua.'..command.name..'()'
end

-- Execute autocmd command
-- The autocmd parameter should follow the structure:
-- {
--    events: list of strings,
--    pattern: string,
--    command: string or { name: string, command: function with no arguments }
-- }
return function(autocmd)
   vim.cmd('autocmd '..processEvents(autocmd.events)..' '..pattern..' '..processCommand(autocmd.command))
end
