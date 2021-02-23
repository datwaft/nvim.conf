-- =======================
-- LIGHTBULB CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  local autocmd = require'core.autocmd'
  autocmd {
    events = { 'CursorHold', 'CursorHoldI' },
    pattern = '*',
    command = {
      name = 'show_lightbulb',
      command = function()
        require'nvim-lightbulb'.update_lightbulb()
      end
    }
  }
end
