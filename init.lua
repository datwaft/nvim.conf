-- A function that applies passes the output of string.format to the print
-- function
---@param string string #template string
local function fprint(string, ...)
	print(string.format(string, ...))
end

-- A function that verifies if the plugin passed as a parameter is installed,
-- if it isn't it will be installed
---@param plugin string #the plugin, must follow the format `username/repository`
---@param branch string? #the branch of the plugin
local function assert_installed_plugin(plugin, branch)
	local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
	local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. plugin_name
	if vim.fn.empty(vim.fn.glob(plugin_path)) ~= 0 then
		fprint("Couldn't find '%s', cloning new copy to %s", plugin_name, plugin_path)
		if branch ~= nil then
			vim.fn.system({
				"git",
				"clone",
				"https://github.com/" .. plugin,
				"--branch",
				branch,
				plugin_path,
			})
		else
			vim.fn.system({
				"git",
				"clone",
				"https://github.com/" .. plugin,
				plugin_path,
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
assert_installed_plugin("wbthomason/packer.nvim")
assert_installed_plugin("rktjmp/hotpot.nvim", "nightly")
assert_installed_plugin("Olical/conjure")
assert_installed_plugin("datwaft/themis.nvim")

if pcall(require, "hotpot") then
	-- Setup hotpot.nvim
	require("hotpot").setup({
		provide_require_fennel = true,
	})
	-- Import neovim configuration
	require("conf")
else
	print("Unable to require hotpot")
end
