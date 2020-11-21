-- =======================
-- LIGHTLINE CONFIGURATION
-- =======================
-- Created by datwaft [github.com/datwaft]

return function()
   vim.g.lightline = {
      colorscheme = 'nightfly',
      active = {
         left = {
            { 'mode', 'paste' },
            { 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' }
         }
      },
      component_function = {
         cocstatus = 'coc#status',
         currentfunction = 'CocCurrentFunction'
      }
   }
end
