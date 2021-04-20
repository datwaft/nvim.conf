-- ==========================
-- NEOVIM INITIALIZATION FILE
-- ==========================
-- Created by datwaft <github.com/datwaft>

-- ===========================
-- Global variable declaration
-- ===========================
  require'globals'
-- ==================
-- Configuration file
-- ==================
  require'configuration'
-- =====================
-- Plugin initialization
-- =====================
  require'plugins'
-- =================
-- LSP initilization
-- =================
  if not require'utils.environment'.isWindows() then
    require'lsp'
  end
