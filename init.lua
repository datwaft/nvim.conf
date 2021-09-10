local package_path_str =
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern =
  "/home/datwaft/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

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
require("hotpot").setup({
  compiler = {
    macros = {env = "_COMPILER", compilerEnv = _G, allowedGlobals = false}
  }
})
require("core")
