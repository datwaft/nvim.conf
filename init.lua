local plugins_path = vim.fn.stdpath("data") .. "/lazy"

-- Bootstrap lazy.nvim
local lazy_path = plugins_path .. "/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
-- Bootstrap hotpot.nvim
local hotpot_path = plugins_path .. "/hotpot.nvim"
if not vim.loop.fs_stat(hotpot_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/rktjmp/hotpot.nvim.git",
    hotpot_path,
  })
end
-- Bootstrap themis.nvim
local themis_path = plugins_path .. "/themis.nvim"
if not vim.loop.fs_stat(themis_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/datwaft/themis.nvim.git",
    themis_path,
  })
end

-- Add lazy.nvim to rtp
vim.opt.runtimepath:prepend(lazy_path)
-- Add hotpot.nvim to rtp
vim.opt.runtimepath:prepend(hotpot_path)
-- Add themis.nvim to rtp
vim.opt.runtimepath:prepend(themis_path)

-- Generate plugins table
local plugins = {
  {
    "rktjmp/hotpot.nvim",
    dependencies = { "datwaft/themis.nvim" },
  },
}

-- Configure hotpot.nvim
require("hotpot").setup({
  provide_require_fennel = true,
})

-- Add plugins to table
for file in vim.fs.dir(vim.fn.stdpath("config") .. "/fnl/conf/plugins") do
  file = file:match("^(.*)%.fnl$")
  plugins[#plugins + 1] = require("conf.plugins." .. file)
end

-- Configure lazy.nvim
require("lazy").setup(plugins)

-- Load configuration
require("conf")
