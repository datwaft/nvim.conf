-- =================================
-- LUA LANGUAGE SERVER CONFIGURATION
-- =================================
-- Created by datwaft <github.com/datwaft>

local io = require'utils.io'
local prerequire = require'utils.prerequire'
local lspconfig = prerequire'lspconfig'
if not lspconfig then return end

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  io.warning('Unsupported system for sumneko, the language server will not'..
    'be initilizated')
end

local root_path = vim.fn.expand'~'..'/.local/share/nvim/lspinstall/'..
  'lua-language-server'
local binary = root_path..'/bin/'..system_name..'/lua-language-server'

lspconfig.sumneko_lua.setup {
  cmd = { binary, '-E', root_path..'/main.lua' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim', 'vimp', 'use' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
