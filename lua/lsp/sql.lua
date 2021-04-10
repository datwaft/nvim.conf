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
    require'sqls'.setup{
      connections = {
        {
          driver = 'postgresql',
          dataSourceName = 'host=172.30.16.1 port=15432 user=postgres password=losiram01 dbname=airline sslmode=disable',
        },
      }
    }
  end
}
