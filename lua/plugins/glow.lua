-- ==================
-- GLOW CONFIGURATION
-- ==================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end
  vimp.nnoremap({'override'}, '<leader>p', ':Glow<cr>')
end
