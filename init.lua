-- Some aliases for easier access.
local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

-- Path of where the plugins are stored.
local pack_path = fn.stdpath("data") .. "/site/pack"

local function ensure(user, repo)
  -- Ensures a given github.com/USER/REPO is cloned int the pack directory.
  local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo,
                install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- Packer is our plugin manager.
ensure("wbthomason", "packer.nvim")

-- Aniseed compiles out Fennel code to Lua and loads it automatically.
ensure("Olical", "aniseed")

-- Enabled Aniseed's automatic compilation and loading of Fennel source code.
-- Aniseed looks for this when it's loaded, then it loads the rest of your
-- configuration if it's set.
vim.g["aniseed#env"] = {module = "core.init"}

-- Now fnl/core/init.fnl is executed.
-- You can use gf to [g]o to the [f]ile.
