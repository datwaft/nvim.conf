-- =================================
-- SQL LANGUAGE SERVER CONFIGURATION
-- =================================
-- Created by datwaft <github.com/datwaft>

local prerequire = require'utils.prerequire'
local lspconfig = prerequire'lspconfig'
if not lspconfig then return end

lspconfig.sqls.setup{
  picker = 'telescope',
  on_attach = function(client)
    client.resolved_capabilities.execute_command = true
    require'sqls'.setup{}
  end
}
