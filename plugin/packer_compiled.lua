-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["AutoSave.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/AutoSave.nvim"
  },
  CamelCaseMotion = {
    config = { "require('core.plugin.camel-case-motion')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/CamelCaseMotion"
  },
  aniseed = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/aniseed"
  },
  colorscheme = {
    config = { "require('core.plugin.colorscheme')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/colorscheme"
  },
  conjure = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/conjure"
  },
  ["gina.vim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "require('core.plugin.gitsigns')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('core.plugin.indent-blankline')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "require('core.plugin.lspsaga')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["nrpattern.nvim"] = {
    config = { "require('core.plugin.nrpattern')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nrpattern.nvim"
  },
  ["nvim-anywise-reg.lua"] = {
    config = { "require('core.plugin.anywise-reg')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-anywise-reg.lua"
  },
  ["nvim-compe"] = {
    config = { "require('core.plugin.compe')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    config = { "require('core.plugin.lightbulb')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    config = { "require('core.plugin.file-explorer')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "require('core.plugin.devicons')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-window.git"] = {
    config = { "require('core.plugin.window')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/nvim-window.git"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  statusline = {
    config = { "require('core.plugin.statusline')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/statusline"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope.nvim"] = {
    config = { "require('core.plugin.telescope')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tmux.nvim"] = {
    config = { "require('core.plugin.tmux')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/tmux.nvim"
  },
  ["traces.vim"] = {
    config = { "require('core.plugin.traces')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/traces.vim"
  },
  treesitter = {
    config = { "require('core.plugin.treesitter')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/treesitter"
  },
  undotree = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-hexokinase"] = {
    config = { "require('core.plugin.hexokinase')" },
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-space"] = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vim-space"
  },
  vimpeccable = {
    loaded = true,
    path = "/home/datwaft/.local/share/nvim/site/pack/packer/start/vimpeccable"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: statusline
time([[Config for statusline]], true)
require('core.plugin.statusline')
time([[Config for statusline]], false)
-- Config for: CamelCaseMotion
time([[Config for CamelCaseMotion]], true)
require('core.plugin.camel-case-motion')
time([[Config for CamelCaseMotion]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('core.plugin.file-explorer')
time([[Config for nvim-tree.lua]], false)
-- Config for: colorscheme
time([[Config for colorscheme]], true)
require('core.plugin.colorscheme')
time([[Config for colorscheme]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require('core.plugin.gitsigns')
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-anywise-reg.lua
time([[Config for nvim-anywise-reg.lua]], true)
require('core.plugin.anywise-reg')
time([[Config for nvim-anywise-reg.lua]], false)
-- Config for: vim-hexokinase
time([[Config for vim-hexokinase]], true)
require('core.plugin.hexokinase')
time([[Config for vim-hexokinase]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('core.plugin.indent-blankline')
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-lightbulb
time([[Config for nvim-lightbulb]], true)
require('core.plugin.lightbulb')
time([[Config for nvim-lightbulb]], false)
-- Config for: treesitter
time([[Config for treesitter]], true)
require('core.plugin.treesitter')
time([[Config for treesitter]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
require('core.plugin.devicons')
time([[Config for nvim-web-devicons]], false)
-- Config for: tmux.nvim
time([[Config for tmux.nvim]], true)
require('core.plugin.tmux')
time([[Config for tmux.nvim]], false)
-- Config for: nrpattern.nvim
time([[Config for nrpattern.nvim]], true)
require('core.plugin.nrpattern')
time([[Config for nrpattern.nvim]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
require('core.plugin.compe')
time([[Config for nvim-compe]], false)
-- Config for: traces.vim
time([[Config for traces.vim]], true)
require('core.plugin.traces')
time([[Config for traces.vim]], false)
-- Config for: nvim-window.git
time([[Config for nvim-window.git]], true)
require('core.plugin.window')
time([[Config for nvim-window.git]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('core.plugin.telescope')
time([[Config for telescope.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
require('core.plugin.lspsaga')
time([[Config for lspsaga.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
