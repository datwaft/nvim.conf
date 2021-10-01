local package_path_str = table.concat({
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua",
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua",
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua",
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
}, ";")
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end
local install_cpath_pattern =
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local hotpot_path = vim.fn.stdpath("data") ..
                      "/site/pack/packer/start/hotpot.nvim"
if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
  print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
  vim.fn.system({
    "git", "clone", "https://github.com/rktjmp/hotpot.nvim", hotpot_path
  })
end

local packer_path = vim.fn.stdpath("data") ..
                      "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  print("Could not find packer.nvim, cloning new copy to", packer_path)
  vim.fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    packer_path
  })
end

require("hotpot").setup({
  provide_require_fennel = true,
  compiler = {
    macros = {env = "_COMPILER", compilerEnv = _G, allowedGlobals = false}
  }
})

local fennel = require("fennel")
table.insert(fennel["macro-searchers"], function(module_name)
  local filename = fennel["search-module"](module_name, package.cpath)
  if filename then
    local func = "luaopen_" .. module_name
    return function() return package.loadlib(filename, func) end, filename
  end
end)

require("crux.core")
