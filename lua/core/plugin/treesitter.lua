local _2afile_2a = ".config/nvim.main/fnl/core/plugin/treesitter.fnl"
local _0_
do
  local name_0_ = "core.plugin.treesitter"
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
    return {autoload("nvim-treesitter.configs")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {config = "nvim-treesitter.configs"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local config = _local_0_[1]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin.treesitter"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
config.setup({autotag = {enable = true}, context_commentstring = {enable = true}, ensure_installed = "maintained", highlight = {enable = true}, indent = {enable = false}, rainbow = {enable = true, extended_mode = true, max_file_lines = 1000}, refactor = {highlight_current_scope = {enable = false}, highlight_definitions = {enable = true}, navigation = {enable = true, keymaps = {goto_definition = "<localleader>gd", goto_next_usage = "<a-*>", goto_previous_usage = "<a-#>", list_definitions = "<localleader>ld", list_definitions_toc = "<localleader>td"}}, smart_rename = {enable = true, keymaps = {smart_rename = "<localleader>rn"}}}, textobjects = {select = {enable = true, keymaps = {["if"] = "@function.inner", aa = "@parameter.outer", ac = "@class.outer", af = "@function.outer", ia = "@parameter.inner", ic = "@class.inner"}, lookahead = true}, swap = {enable = true, swap_next = {["<localleader>>"] = "@parameter.inner"}, swap_previous = {["<localleader><"] = "@parameter.inner"}}}})
vim.opt.foldmethod = "expr"
return vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")