-- ==============
-- MODULE LIBRARY
-- ==============
-- Created by datwaft <github.com/datwaft>

return {
  -- Create a new module
  -- The argument should follow the structure: 
  -- {
  --   name: string,
  -- }
  new = function(module)
    return setmetatable(module, {
      __index = function(self, key)
        require'utils.io'
          .warning(
            string.format(
              "Tried to index module '%s' with invalid key '%s'",
              self.name,
              key
            )
          )
      end,
    })
  end
}
