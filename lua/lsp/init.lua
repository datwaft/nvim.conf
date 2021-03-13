-- ==================
-- LSP INITIALIZATION
-- ==================
-- Created by datwaft <github.com/datwaft>

local LSPs = {
  'lua',
  'python',
  'bash',
  'c',
  'cmake',
  'rust',
  'typescript',
  'vue',
}

for _, lsp in ipairs(LSPs) do
  require('lsp.'..lsp)
end
