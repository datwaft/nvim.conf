local _2afile_2a = ".config/nvim.main/fnl/core/plugin/tmux.fnl"
local _0_
do
  local name_0_ = "core.plugin.tmux"
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
    return {autoload("vimp"), autoload("tmux")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {m = "vimp", plugin = "tmux"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local m = _local_0_[1]
local plugin = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin.tmux"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
plugin.setup({copy_sync = {enable = false}, navigation = {enable_default_keybindings = false}, resize = {enable_default_keybindings = false}})
m.nnoremap({"override", "silent"}, "<C-w>h", "<cmd>lua require('tmux').move_left()<cr>")
m.nnoremap({"override", "silent"}, "<C-w>j", "<cmd>lua require('tmux').move_bottom()<cr>")
m.nnoremap({"override", "silent"}, "<C-w>k", "<cmd>lua require('tmux').move_top()<cr>")
m.nnoremap({"override", "silent"}, "<C-w>l", "<cmd>lua require('tmux').move_right()<cr>")
m.nnoremap({"override", "silent"}, "<M-h>", "<cmd>lua require('tmux').resize_left()<cr>")
m.nnoremap({"override", "silent"}, "<M-j>", "<cmd>lua require('tmux').resize_bottom()<cr>")
m.nnoremap({"override", "silent"}, "<M-k>", "<cmd>lua require('tmux').resize_top()<cr>")
return m.nnoremap({"override", "silent"}, "<M-l>", "<cmd>lua require('tmux').resize_right()<cr>")