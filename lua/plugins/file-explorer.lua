-- ===========================
-- FILE EXPLORER CONFIGURATION
-- ===========================
-- Created by datwaft <github.com/datwaft

return function()
  if not vimp then
    return
  end
  vimp.nnoremap({'override', 'silent'}, '<C-n>', ':Fern . -drawer -toggle -width=40 -reveal=%<cr>')
  vim.g['fern#renderer'] = 'nerdfont'
end
