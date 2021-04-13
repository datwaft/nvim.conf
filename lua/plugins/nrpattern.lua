-- =======================
-- NRPATTERN CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  local prerequire = require'utils.prerequire'
  local io = require'utils.io'

  local nrpattern = prerequire'nrpattern'
  if not nrpattern then
    io.warning"Couldn't load `nrpattern` package"
    return
  end

  nrpattern.setup()
end
