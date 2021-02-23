-- =======================
-- TELESCOPE CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end
  vimp.nnoremap({'override'}, '<leader>ff', '<cmd>Telescope find_files<cr>')
  vimp.nnoremap({'override'}, '<leader>fg', '<cmd>Telescope live_grep<cr>')
  vimp.nnoremap({'override'}, '<leader>fb', '<cmd>Telescope buffers<cr>')
  vimp.nnoremap({'override'}, '<leader>fh', '<cmd>Telescope help_tags<cr>')
end
