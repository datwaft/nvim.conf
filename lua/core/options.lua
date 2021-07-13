local _2afile_2a = ".config/nvim.main/fnl/core/options.fnl"
local _0_
do
  local name_0_ = "core.options"
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
local _2amodule_name_2a = "core.options"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local configuration_folder
do
  local v_0_ = vim.fn.stdpath("config")
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["configuration-folder"] = v_0_
  configuration_folder = v_0_
end
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
vim.opt.undodir = (configuration_folder .. "/undodir.nvim")
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
local function _3_()
  return vim.fn.printf("  \239\144\173 %-6d%s", (vim.v.foldend - (vim.v.foldstart + 1)), vim.fn.getline(vim.v.foldstart))
end
_G["__core_foldtext"] = _3_
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