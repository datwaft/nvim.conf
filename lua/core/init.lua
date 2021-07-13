package.preload["core.lsp"] = package.preload["core.lsp"] or function(...)
  module(core.lsp, {[autoload] = {[__fnl_global__lua_2ddev] = __fnl_global__lua_2ddev, [a] = aniseed.core, [config] = lspconfig, [signature] = lsp_signature}})
  local function _1_()
    return signature.on_attach()
  end
  __fnl_global__def_2d(__fnl_global__global_2doptions, {on_attach = _1_})
  local function _2_(...)
    if (1 == vim.fn.has("mac")) then
      return "macOS"
    elseif (1 == vim.fn.has("unix")) then
      return "Linux"
    elseif (1 == vim.fn.has("win32")) then
      return "Windows"
    end
  end
  __fnl_global__def_2d(system_name, _2_(...))
  __fnl_global__def_2d(root_path, (vim.fn.expand("~") .. "/.local/share/nvim/lspinstall/lua-language-server"))
  __fnl_global__def_2d(binary, (root_path .. "/bin/" .. system_name .. "/lua-language-server"))
  config.bashls.setup(a.merge(__fnl_global__global_2doptions, {}))
  config.clangd.setup(a.merge(__fnl_global__global_2doptions, {}))
  config.cmake.setup(a.merge(__fnl_global__global_2doptions, {}))
  config.sumneko_lua.setup(__fnl_global__lua_2ddev.setup({lspconfig = a.merge(__fnl_global__global_2doptions, {cmd = {binary, "-E", (root_path .. "/main.lua")}})}))
  config.pyright.setup(a.merge(__fnl_global__global_2doptions, {}))
  config.r_language_server.setup(a.merge(__fnl_global__global_2doptions, {}))
  config.rust_analyzer.setup(a.merge(__fnl_global__global_2doptions, {}))
  config.tsserver.setup(a.merge(__fnl_global__global_2doptions, {}))
  return config.vuels.setup(a.merge(__fnl_global__global_2doptions, {}))
end
package.preload["core.globals"] = package.preload["core.globals"] or function(...)
  module(core.globals)
  local function _1_(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    return print(unpack(objects))
  end
  _G["dump"] = _1_
  return nil
end
package.preload["core.plugin"] = package.preload["core.plugin"] or function(...)
  module(core.plugin, {[autoload] = {[a] = aniseed.core, [packer] = packer}})
  local function _1_(...)
    local pkgs = {...}
    local function _2_(use)
      for i = 1, a.count(pkgs), 2 do
        local name = pkgs[i]
        local opts = pkgs[(i + 1)]
        use(a.assoc(opts, 1, name))
      end
      return nil
    end
    return packer.startup(_2_)
  end
  __fnl_global__defn_2d(use, {...}, "Iterates through the arguments as pairs and calls packer's use function for\n  each of them. Works around Fennel not liking mixed associative and sequential\n  tables as well.\n\n  This is just a helper / syntax sugar function to make interacting with packer\n  a little more concise.", _1_(...))
  __fnl_global__defn_2d(req, {name}, "A shortcut to building a require string for your plugin\n  configuration. Intended for use with packer's config or setup\n  configuration options. Will prefix the name with `core.plugin.`\n  before requiring.", ("require('core.plugin." .. name .. "')"))
  return use("sainnhe/edge", {as = "colorscheme", config = req("colorscheme")}, "datwaft/bubbly.nvim", {as = "statusline", config = req("statusline")}, "nvim-treesitter/nvim-treesitter", {as = "treesitter", config = req("treesitter"), run = ":TSUpdate"}, "nvim-treesitter/nvim-treesitter-refactor", {requires = "treesitter"}, "nvim-treesitter/nvim-treesitter-textobjects", {requires = "treesitter"}, "p00f/nvim-ts-rainbow", {requires = "treesitter"}, "JoosepAlviste/nvim-ts-context-commentstring", {requires = "treesitter"}, "windwp/nvim-ts-autotag", {requires = "treesitter"}, "markonm/traces.vim", {config = req("traces")}, "rrethy/vim-hexokinase", {config = req("hexokinase"), run = "make hexokinase"}, "lukas-reineke/indent-blankline.nvim", {config = req("indent-blankline")}, "kyazdani42/nvim-web-devicons", {config = req("devicons")}, "wellle/targets.vim", {}, "michaeljsmith/vim-indent-object", {}, "bkad/CamelCaseMotion", {config = req("camel-case-motion")}, "vim-utils/vim-space", {}, "tpope/vim-commentary", {}, "machakann/vim-sandwich", {}, "zegervdv/nrpattern.nvim", {config = req("nrpattern"), requires = {"tpope/vim-repeat"}}, "tpope/vim-abolish", {}, "mbbill/undotree", {}, "lewis6991/gitsigns.nvim", {config = req("gitsigns"), requires = {"nvim-lua/plenary.nvim"}}, "lambdalisue/gina.vim", {}, "aserowy/tmux.nvim", {config = req("tmux")}, "nvim-telescope/telescope.nvim", {config = req("telescope"), requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}}, "kyazdani42/nvim-tree.lua", {config = req("file-explorer")}, "https://gitlab.com/yorickpeterse/nvim-window.git", {config = req("window")}, "AckslD/nvim-anywise-reg.lua", {config = req("anywise-reg")}, "Pocco81/AutoSave.nvim", {}, "neovim/nvim-lspconfig", {}, "anott03/nvim-lspinstall", {}, "nvim-lua/lsp-status.nvim", {}, "hrsh7th/nvim-compe", {config = req("compe")}, "ray-x/lsp_signature.nvim", {}, "folke/lua-dev.nvim", {}, "kosayoda/nvim-lightbulb", {config = req("lightbulb")}, "glepnir/lspsaga.nvim", {config = req("lspsaga")}, "Olical/aniseed", {}, "Olical/conjure", {}, "svermeulen/vimpeccable", {}, "wbthomason/packer.nvim", {})
end
package.preload["core.autocmd"] = package.preload["core.autocmd"] or function(...)
  module(core.autocmd, {[__fnl_global__require_2dmacros] = {core.macros}, [autoload] = {[a] = aniseed.core, [nvim] = aniseed.nvim, [s] = aniseed.string}})
  do end (_G)["__autocmd_id"] = 0
  local function _1_(...)
    if a["string?"](command) then
      return command
    else
      local name
      local function _1_(...)
        _G["__autocmd_id"] = a.inc(_G.__autocmd_id)
        return _G.__autocmd_id
      end
      name = a.str("__autocmd_", _1_(...))
      do end (_G)[name] = command
      return ("call v:lua." .. name .. "()")
    end
  end
  __fnl_global__defn_2d(__fnl_global__process_2dcommand, {command}, _1_(...))
  local function _2_(...)
    local events
    if a["table?"](events) then
      events = events
    else
      events = {events}
    end
    local pattern
    if a["table?"](pattern) then
      pattern = pattern
    else
      pattern = {pattern}
    end
    local events0 = s.join(",", events)
    local pattern0 = s.join(",", pattern)
    return nvim.ex.autocmd(events0, pattern0, __fnl_global__process_2dcommand(command))
  end
  defn(autocmd, {events, pattern, command}, _2_(...))
  augroup(__fnl_global__restore_2dcursor_2don_2dexit, autocmd("VimLeave", "*", "set guicursor=a:ver100-blinkon0"))
  augroup(__fnl_global__resize_2dsplits_2don_2dresize, autocmd("VimResized", "*", "wincmd ="))
  local function _3_()
    if ((vim.fn.mode() ~= "c") and (vim.fn.bufexists("[Command Line]") == 0)) then
      return vim.cmd("checktime")
    end
  end
  augroup(__fnl_global__read_2dfile_2don_2ddisk_2dchange, autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, "*", _3_), autocmd("FileChangedShellPost", "*", "echom \"File changed on disk. Buffer reloaded.\""))
  local function _4_()
    if ((vim.fn.line("'\"") > 1) and (vim.fn.line("'\"") <= vim.fn.line("$"))) then
      return vim.cmd("normal! g'\"")
    end
  end
  augroup(__fnl_global__open_2dfile_2don_2dlast_2dposition, autocmd("BufReadPost", "*", _4_))
  augroup(__fnl_global__disable_2dspell_2don_2dfiletypes, autocmd("FileType", {"help", "packer"}, "setlocal nospell"))
  return augroup(__fnl_global__terminal_2doptions, autocmd("TermOpen", "*", "startinsert"), autocmd("TermOpen", "*", "setlocal nonumber norelativenumber"), autocmd("TermOpen", "*", "setlocal nospell"), autocmd("TermOpen", "*", "setlocal signcolumn=\"no\""))
end
package.preload["core.mapping"] = package.preload["core.mapping"] or function(...)
  module(core.mapping, {[autoload] = {[a] = aniseed.core, [m] = vimp}})
  m.cnoremap({"override", "expr"}, "<space>", "wildmenumode() ? \"\\<C-y>\" : \"\\<space>\"")
  m.nnoremap({"override", "silent"}, "H", "^")
  m.nnoremap({"override", "silent"}, "L", "$")
  m.inoremap({"override", "silent"}, "<C-h>", "<C-o>^")
  m.inoremap({"override", "silent"}, "<C-l>", "<C-o>$")
  m.cnoremap({"override"}, "<C-h>", "<home>")
  m.cnoremap({"override"}, "<C-l>", "<end>")
  m.nnoremap({"override", "silent"}, "Y", "y$")
  m.xnoremap({"override", "silent"}, "Q", ":normal @@<CR>")
  m.nnoremap({"override", "silent"}, "Q", ":normal @@<CR>")
  m.nnoremap({"override", "silent"}, "<C-k>", ":m-2<CR>")
  m.nnoremap({"override", "silent"}, "<C-up>", ":m-2<CR>")
  m.nnoremap({"override", "silent"}, "<C-j>", ":m+<CR>")
  m.nnoremap({"override", "silent"}, "<C-down>", ":m+<CR>")
  m.xnoremap({"override", "silent"}, "il", ":<C-u>normal! g_v^<cr>")
  m.onoremap({"override", "silent"}, "il", ":<C-u>normal! g_v^<cr>")
  m.xnoremap({"override", "silent"}, "al", ":<C-u>normal! $v0<cr>")
  m.onoremap({"override", "silent"}, "al", ":<C-u>normal! $v0<cr>")
  m.xnoremap({"override", "silent"}, "id", ":<C-u>normal! G$Vgg0<cr>")
  return m.onoremap({"override", "silent"}, "id", ":<C-u>normal! GVgg<cr>")
end
package.preload["core.options"] = package.preload["core.options"] or function(...)
  module(core.options)
  __fnl_global__def_2d(__fnl_global__configuration_2dfolder, vim.fn.stdpath("config"))
  vim.g.python3_host_prog = "/usr/bin/python3"
  vim.opt.backup = false
  vim.opt.writebackup = false
  vim.opt.swapfile = false
  vim.opt.expandtab = true
  vim.opt.smarttab = true
  do
    local value = 2
    vim.opt.tabstop = value
    vim.opt.shiftwidth = value
    vim.opt.softtabstop = value
  end
  vim.opt.wrap = true
  vim.opt.linebreak = false
  vim.opt.breakindent = true
  vim.opt.breakindentopt = {"shift:2"}
  vim.opt.showbreak = "\226\134\179 "
  vim.opt.formatoptions = {"q", "j"}
  vim.opt.spell = true
  vim.opt.spelllang = {"en"}
  vim.opt.spelloptions = {"camel"}
  vim.opt.undodir = (__fnl_global__configuration_2dfolder .. "/undodir.nvim")
  vim.opt.undofile = true
  vim.opt.mouse = "a"
  vim.opt.termguicolors = true
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.hlsearch = false
  vim.opt.concealcursor = ""
  vim.opt.showmode = false
  vim.opt.colorcolumn = {81}
  vim.opt.list = true
  vim.opt.listchars = {nbsp = "\194\183", tab = "\226\134\146 ", trail = "\194\183"}
  vim.opt.signcolumn = "yes"
  vim.opt.foldlevelstart = 99
  local function _1_()
    return vim.fn.printf("  \239\144\173 %-6d%s", (vim.v.foldend - (vim.v.foldstart + 1)), vim.fn.getline(vim.v.foldstart))
  end
  _G["__core_foldtext"] = _1_
  vim.opt.fillchars = "fold: "
  vim.opt.foldtext = "v:lua.__core_foldtext()"
  vim.opt.infercase = true
  do end (vim.opt.shortmess):append("c")
  vim.opt.wildmenu = true
  vim.opt.wildcharm = 9
  vim.opt.wildignorecase = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.gdefault = true
  vim.opt.pastetoggle = "<F3>"
  vim.opt.diffopt = {"filler", "internal", "indent-heuristic", "algorithm:histogram"}
  vim.opt.backspace = {"indent", "eol", "start"}
  vim.opt.lazyredraw = true
  vim.opt.hidden = true
  return vim.cmd("let maplocalleader = \" \"")
end
local _2afile_2a = ".config/nvim.main/fnl/core/init.fnl"
local _0_
do
  local name_0_ = "core.init"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  do end (module_0_)["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  do end (package.loaded)[name_0_] = module_0_
  _0_ = module_0_
end
local autoload
local function _1_(...)
  return (require("aniseed.autoload")).autoload(...)
end
autoload = _1_
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.init"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
require("core.options")
require("core.mapping")
require("core.autocmd")
require("core.plugin")
require("core.globals")
return require("core.lsp")