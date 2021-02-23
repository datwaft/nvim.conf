-- =======================
-- TELESCOPE CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end
  vimp.nnoremap('<leader>ff', '<cmd>Telescope find_files<cr>')
  vimp.nnoremap('<leader>fg', '<cmd>Telescope live_grep<cr>')
  vimp.nnoremap('<leader>fb', '<cmd>Telescope buffers<cr>')
  vimp.nnoremap('<leader>fh', '<cmd>Telescope help_tags<cr>')
end
