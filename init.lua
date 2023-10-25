local packages_path = vim.fn.stdpath("data") .. "/lazy"

---@param name string
---@param alias string?
local function install_package(name, alias)
  ---@type unknown, unknown, string, string
  local _, _, owner, repo = name:find([[(.+)/(.+)]])
  local path = ("%s/%s"):format(packages_path, alias or repo)

  if not vim.loop.fs_stat(path) then
    vim.notify(("Installing %s/%s..."):format(owner, repo), vim.log.levels.INFO)

    local command = {
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      ("https://github.com/%s/%s.git"):format(owner, repo),
      path,
    }

    vim.fn.system(command)
  end

  vim.opt.runtimepath:prepend(path)
end

-- Enable bytecode cache
vim.loader.enable()

-- Install essential plugins
install_package("folke/lazy.nvim")
install_package("rktjmp/hotpot.nvim")
install_package("datwaft/themis.nvim")
install_package("catppuccin/nvim", "catppuccin")
install_package("f-person/auto-dark-mode.nvim")

-- Set colorscheme
vim.cmd.colorscheme("catppuccin")

-- Configure hotpot.nvim
require("hotpot").setup({
  enable_hotpot_diagnostics = false,
  compiler = {
    ---@param source string
    ---@param module { path: string, modname: string, macro: boolean }
    preprocessor = function(source, module)
      local path = module.path
      local macro = module.macro
      if not macro and path and path:match("config/nvim") then
        return "(import-macros {: set! : local-set!} :themis.opt)\n"
            .. "(import-macros {: let!} :themis.var)\n"
            .. "(import-macros {: map! : buf-map!} :themis.keybind)\n"
            .. "(import-macros {: augroup! : autocmd! : clear!} :themis.event)\n"
            .. "(import-macros {: pack} :themis.pack.lazy)\n"
            .. source
      end
      return source
    end,
  },
})

-- Generate packages table
local packages = {
  { "rktjmp/hotpot.nvim",           dependencies = { "datwaft/themis.nvim" } },
  { "catppuccin/nvim",              name = "catppuccin",                     priority = 1000 },
  { "f-person/auto-dark-mode.nvim", config = true },
}

-- Populate plugins table with packages.* modules
local packages_folder = vim.fn.stdpath("config") .. "/fnl/packages"
if vim.loop.fs_stat(packages_folder) then
  for file in vim.fs.dir(packages_folder) do
    file = file:match("^(.*)%.fnl$")
    table.insert(packages, require("packages." .. file))
  end
end

-- Load configuration
require("options")
require("mappings")
require("events")
require("diagnostics")

-- Configure lazy.nvim
require("lazy").setup(packages)
