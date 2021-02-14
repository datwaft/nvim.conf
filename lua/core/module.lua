-- ==============
-- MODULE LIBRARY
-- ==============
-- Created by datwaft <github.com/datwaft>

return {
   -- Create new module with a name
   new = function(name)
      if name == nil then name = 'UNKNOWN' end
      return setmetatable({
         name = name,
      }, {
         __index = function(self, key)
            require'utils.io'.warning(string.format("[CORE] => [Warning] Tried to index module '%s' with invalid key '%s'", self.name, key))
         end,
      })
   end
}
