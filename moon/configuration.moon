-- CONFIGURATION.LUA
-- =================
-- Created by: datwaft [github.com/datwaft]

-- Terminal configuration
-- ======================
-- Mouse support
vim.o.mouse = 'a'
-- Editor configuration
-- ====================
-- Tabulation configuration
with expandtab = true
   vim.o.expandtab = expandtab
   vim.bo.expandtab = expandtab
with smarttab = true
   vim.o.smarttab = smarttab
with tabstop = 3
   vim.o.tabstop = tabstop
   vim.bo.tabstop = tabstop
with shiftwidth = vim.o.tabstop
   vim.o.shiftwidth = shiftwidth
   vim.bo.shiftwidth = shiftwidth
with softtabstop = vim.o.tabstop
   vim.o.softtabstop = softtabstop
   vim.bo.softtabstop = softtabstop
-- Indentation configuration
with autoindent = true
   vim.o.autoindent = autoindent
   vim.bo.autoindent = autoindent
