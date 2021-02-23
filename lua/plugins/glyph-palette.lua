-- ===========================
-- GLYPH PALETTE CONFIGURATION
-- ===========================
-- Created by datwaft <github.com/datwaft

return function()
  local autocmd = require'core.autocmd'
  autocmd {
    events = { 'Filetype' },
    pattern = 'fern',
    command = 'call glyph_palette#apply()',
  }
end
