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
      name = 'update_lightbulb',
      command = function()
        require'nvim-lightbulb'.update_lightbulb {
          sign = {
            enabled = false,
          },
          float = {
            enabled = false,
          },
          virtual_text = {
            enabled = true,
          }
        }
      end
    }
  }
end
