-- ======================
-- GITSIGNS CONFIGURATION
-- ======================
-- Created by datwaft <github.com/datwaft>

return function()
  require'gitsigns'.setup {
    signs = {
      add          = {hl = 'GitGutterAdd'   , text = '│'},
      change       = {hl = 'GitGutterChange', text = '│'},
      delete       = {hl = 'GitGutterDelete', text = '_'},
      topdelete    = {hl = 'GitGutterDelete', text = '‾'},
      changedelete = {hl = 'GitGutterChange', text = '~'},
    }
  }
end
