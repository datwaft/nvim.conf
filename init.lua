-- Like calling `print(string.format(template, ...))`
---@param template string #See `string.format` for more information
local function fprint(template, ...)
  print(string.format(template, ...))
end

-- Install plugin if it is not installed
---@param plugin string #Must follow the pattern `username/repository`
---@param branch string? #The branch to clone
local function install_if_not(plugin, branch)
  local _, _, name = string.find(plugin, [[%S+/(%S+)]])
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. name
  if not vim.loop.fs_stat(path) then
    fprint("Couldn't find '%s', cloning new copy to %s", name, path)
    if branch ~= nil then
      vim.fn.system({
        "git",
        "clone",
        "https://github.com/" .. plugin .. ".git",
        "--branch",
        branch,
        path,
      })
    else
      vim.fn.system({
        "git",
        "clone",
        "https://github.com/" .. plugin .. ".git",
        path,
      })
    end
  end
end

-- Set essential options
vim.opt.expandtab = true
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.g.maplocalleader = vim.api.nvim_replace_termcodes("<space>", true, true, true)

-- Install essential plugins
install_if_not("wbthomason/packer.nvim")
install_if_not("rktjmp/hotpot.nvim")
install_if_not("datwaft/themis.nvim")

if pcall(require, "hotpot") then
  -- Setup hotpot.nvim
  require("hotpot").setup({
    enable_hotpot_diagnostics = false,
    provide_require_fennel = true,
  })
  -- AOT compile
  require("hotpot.api.make").build(
    vim.fn.stdpath("config"),
    { verbosity = 0 },
    vim.fn.stdpath("config") .. "/ftplugin/.+",
    function(path)
      return path
    end,
    vim.fn.stdpath("config") .. "/after/ftdetect/.+",
    function(path)
      return path
    end,
    vim.fn.stdpath("config") .. "/after/ftplugin/.+",
    function(path)
      return path
    end,
    vim.fn.stdpath("config") .. "/fnl/conf/health.fnl",
    function()
      return vim.fn.stdpath("config") .. "/lua/conf/health.lua"
    end
  )
  -- Import neovim configuration
  require("conf")
else
  print("Unable to require hotpot")
end
