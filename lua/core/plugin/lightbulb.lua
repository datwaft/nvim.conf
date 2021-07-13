local _2afile_2a = ".config/nvim.main/fnl/core/plugin/lightbulb.fnl"
local _0_
do
  local name_0_ = "core.plugin.lightbulb"
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
    return {autoload("core.autocmd"), autoload("nvim-lightbulb")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {["require-macros"] = {["core.macros"] = true}, autoload = {au = "core.autocmd", plugin = "nvim-lightbulb"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local au = _local_0_[1]
local plugin = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin.lightbulb"
do local _ = ({nil, _0_, nil, {{nil}, nil, nil, nil}})[2] end
do
  vim.cmd(("augroup " .. "update-lightbulb" .. "\nautocmd!"))
  local function _3_()
    return plugin.update_lightbulb({sign = {enabled = false}, virtual_text = {enabled = true, text = "\239\131\171"}})
  end
  au.autocmd({"CursorHold", "CursorHoldI"}, "*", _3_)
  vim.cmd("augroup END")
end
return vim.cmd("highlight link LightBulbVirtualText Red")