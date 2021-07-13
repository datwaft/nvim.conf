local _2afile_2a = ".config/nvim.main/fnl/core/plugin/camel-case-motion.fnl"
local _0_
do
  local name_0_ = "core.plugin.camel-case-motion"
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
    return {autoload("aniseed.core"), autoload("vimp")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {a = "aniseed.core", m = "vimp"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local m = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin.camel-case-motion"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
m.nmap({"override", "silent"}, "<leader>w", "<Plug>CamelCaseMotion_w")
m.vmap({"override", "silent"}, "<leader>w", "<Plug>CamelCaseMotion_w")
m.omap({"override", "silent"}, "<leader>w", "<Plug>CamelCaseMotion_w")
m.nmap({"override", "silent"}, "<leader>b", "<Plug>CamelCaseMotion_b")
m.vmap({"override", "silent"}, "<leader>b", "<Plug>CamelCaseMotion_b")
m.omap({"override", "silent"}, "<leader>b", "<Plug>CamelCaseMotion_b")
m.nmap({"override", "silent"}, "<leader>e", "<Plug>CamelCaseMotion_e")
m.vmap({"override", "silent"}, "<leader>e", "<Plug>CamelCaseMotion_e")
m.omap({"override", "silent"}, "<leader>e", "<Plug>CamelCaseMotion_e")
m.xmap({"override", "silent"}, "i<leader>w", "<Plug>CamelCaseMotion_ie")
return m.omap({"override", "silent"}, "i<leader>w", "<Plug>CamelCaseMotion_ie")