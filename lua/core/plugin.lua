local _2afile_2a = ".config/nvim.main/fnl/core/plugin.fnl"
local _0_
do
  local name_0_ = "core.plugin"
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
    return {autoload("aniseed.core"), autoload("packer")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {a = "aniseed.core", packer = "packer"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local packer = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local use
do
  local v_0_
  local function use0(...)
    local pkgs = {...}
    local function _3_(use1)
      for i = 1, a.count(pkgs), 2 do
        local name = pkgs[i]
        local opts = pkgs[(i + 1)]
        use1(a.assoc(opts, 1, name))
      end
      return nil
    end
    return packer.startup(_3_)
  end
  v_0_ = use0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["use"] = v_0_
  use = v_0_
end
local req
do
  local v_0_
  local function req0(name)
    return ("require('core.plugin." .. name .. "')")
  end
  v_0_ = req0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["req"] = v_0_
  req = v_0_
end
return use("sainnhe/edge", {as = "colorscheme", config = req("colorscheme")}, "datwaft/bubbly.nvim", {as = "statusline", config = req("statusline")}, "nvim-treesitter/nvim-treesitter", {as = "treesitter", config = req("treesitter"), run = ":TSUpdate"}, "nvim-treesitter/nvim-treesitter-refactor", {requires = "treesitter"}, "nvim-treesitter/nvim-treesitter-textobjects", {requires = "treesitter"}, "p00f/nvim-ts-rainbow", {requires = "treesitter"}, "JoosepAlviste/nvim-ts-context-commentstring", {requires = "treesitter"}, "windwp/nvim-ts-autotag", {requires = "treesitter"}, "markonm/traces.vim", {config = req("traces")}, "rrethy/vim-hexokinase", {config = req("hexokinase"), run = "make hexokinase"}, "lukas-reineke/indent-blankline.nvim", {config = req("indent-blankline")}, "kyazdani42/nvim-web-devicons", {config = req("devicons")}, "wellle/targets.vim", {}, "michaeljsmith/vim-indent-object", {}, "bkad/CamelCaseMotion", {config = req("camel-case-motion")}, "vim-utils/vim-space", {}, "tpope/vim-commentary", {}, "machakann/vim-sandwich", {}, "zegervdv/nrpattern.nvim", {config = req("nrpattern"), requires = {"tpope/vim-repeat"}}, "tpope/vim-abolish", {}, "mbbill/undotree", {}, "lewis6991/gitsigns.nvim", {config = req("gitsigns"), requires = {"nvim-lua/plenary.nvim"}}, "lambdalisue/gina.vim", {}, "aserowy/tmux.nvim", {config = req("tmux")}, "nvim-telescope/telescope.nvim", {config = req("telescope"), requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}}, "kyazdani42/nvim-tree.lua", {config = req("file-explorer")}, "https://gitlab.com/yorickpeterse/nvim-window.git", {config = req("window")}, "AckslD/nvim-anywise-reg.lua", {config = req("anywise-reg")}, "Pocco81/AutoSave.nvim", {}, "neovim/nvim-lspconfig", {}, "anott03/nvim-lspinstall", {}, "nvim-lua/lsp-status.nvim", {}, "hrsh7th/nvim-compe", {config = req("compe")}, "ray-x/lsp_signature.nvim", {}, "folke/lua-dev.nvim", {}, "kosayoda/nvim-lightbulb", {config = req("lightbulb")}, "glepnir/lspsaga.nvim", {config = req("lspsaga")}, "Olical/aniseed", {}, "Olical/conjure", {}, "svermeulen/vimpeccable", {}, "wbthomason/packer.nvim", {})