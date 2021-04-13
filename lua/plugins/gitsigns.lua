-- ======================
-- GITSIGNS CONFIGURATION
-- ======================
-- Created by datwaft <github.com/datwaft>

return function()
  local prerequire = require'utils.prerequire'
  local io = require'utils.io'

  local gitsigns = prerequire'gitsigns'
  if not gitsigns then
    io.warning"Couldn't load `gitsigns` package"
    return
  end
  gitsigns.setup {
    signs = {
      add          = {hl = 'GitGutterAdd'   , text = '│'},
      change       = {hl = 'GitGutterChange', text = '│'},
      delete       = {hl = 'GitGutterDelete', text = '_'},
      topdelete    = {hl = 'GitGutterDelete', text = '‾'},
      changedelete = {hl = 'GitGutterChange', text = '~'},
    }
  }
end
