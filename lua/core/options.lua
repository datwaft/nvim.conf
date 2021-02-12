-- ===============
-- OPTIONS LIBRARY
-- ===============
-- Created by datwaft <github.com/datwaft>

local options_info = vim.api.nvim_get_all_options_info()

return setmetatable({}, {
   __index = function(_, key)
      local isglobal, value = pcall(function() return vim.o[key] end)
      if isglobal then return value end
      local scope = options_info[key].scope
      if scope == 'win' then
         return vim.wo[key]
      elseif scope == 'buf' then
         return vim.bo[key]
      end
   end,
   __newindex = function(_, key, value)
      pcall(function() vim.o[key] = value end)
      local scope = options_info[key].scope
      if scope == 'win' then
         vim.wo[key] = value
      elseif scope == 'buf' then
         vim.bo[key] = value
      end
   end,
})
