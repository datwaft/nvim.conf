-- ===========================
-- LSP SIGNATURE CONFIGURATION
-- ===========================
-- Created by datwaft <github.com/datwaft>

return function()
  local prerequire = require'utils.prerequire'
  local io = require'utils.io'

  local signature = prerequire'lsp_signature'
  if not signature then
    io.warning"Couldn't load `lsp_signature` package"
    return
  end

  signature.on_attach()
end
