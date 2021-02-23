-- ==================
-- LSP INITIALIZATION
-- ==================
-- Created by datwaft <github.com/datwaft>

local LSPs = {
  'lua',
  'python',
}

for _, lsp in ipairs(LSPs) do
  require('lsp.'..lsp)
end
