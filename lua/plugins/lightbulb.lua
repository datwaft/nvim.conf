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
          virtual_text = {
            enabled = true,
            text = '',
          }
        }
      end
    }
  }
  vim.api.nvim_command('highlight link LightBulbVirtualText Red')
end
