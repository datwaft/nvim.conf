local plugins_path = vim.fn.stdpath("data") .. "/lazy"

---@param name string
local function install_plugin(name)
  ---@type unknown, unknown, string, string
  local _, _, owner, repo = string.find(name, "(.+)/(.+)")
  local path = ("%s/%s"):format(plugins_path, repo)

  if not vim.loop.fs_stat(path) then
    vim.notify(("Installing %s/%s..."):format(owner, repo), vim.log.levels.INFO)
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      ("https://github.com/%s/%s.git"):format(owner, repo),
      path,
    })
  end

  vim.opt.runtimepath:prepend(path)
end

-- Enable bytecode cache
vim.loader.enable()

-- Install essential plugins
install_plugin("folke/lazy.nvim")
install_plugin("rktjmp/hotpot.nvim")
install_plugin("datwaft/themis.nvim")

-- Configure hotpot.nvim
require("hotpot").setup({
  provide_require_fennel = true,
  compiler = {
    modules = {
      correlate = true,
    },
  },
})

-- Generate plugins table
local plugins = {
  {
    "rktjmp/hotpot.nvim",
    dependencies = { "datwaft/themis.nvim" },
  },
}

-- Load configuration
require("conf")

-- Add conf.plugins.* to plugins list
local plugins_path = vim.fn.stdpath("config") .. "/fnl/conf/plugins"
if vim.loop.fs_stat(plugins_path) then
  for file in vim.fs.dir(plugins_path) do
    file = file:match("^(.*)%.fnl$")
    table.insert(plugins, require("conf.plugins." .. file))
  end
end
-- Add conf.lsp to plugins table
table.insert(plugins, require("conf.lsp"))

-- Configure lazy.nvim
require("lazy").setup(plugins)
