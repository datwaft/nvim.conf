-- =======================
-- LIGHTLINE CONFIGURATION
-- =======================
-- Created by datwaft [github.com/datwaft]

return function()
   vim.cmd [[
      function! CocCurrentFunction()
         return get(b:, 'coc_current_function', '')
      endfunction
   ]]

   vim.g.lightline = {
      colorscheme = vim.g.statusline_theme,
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
