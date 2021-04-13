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
  if vim.fn.exists('g:vscode') == 0 then
    require'lsp'
  end
