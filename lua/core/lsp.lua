local _2afile_2a = ".config/nvim.main/fnl/core/lsp.fnl"
local _0_
do
  local name_0_ = "core.lsp"
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
    return {autoload("aniseed.core"), autoload("lspconfig"), autoload("lua-dev"), autoload("lsp_signature")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {["lua-dev"] = "lua-dev", a = "aniseed.core", config = "lspconfig", signature = "lsp_signature"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local config = _local_0_[2]
local lua_dev = _local_0_[3]
local signature = _local_0_[4]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.lsp"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local global_options
do
  local v_0_
  local function _3_()
    return signature.on_attach()
  end
  v_0_ = {on_attach = _3_}
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["global-options"] = v_0_
  global_options = v_0_
end
local system_name
do
  local v_0_
  if (1 == vim.fn.has("mac")) then
    v_0_ = "macOS"
  elseif (1 == vim.fn.has("unix")) then
    v_0_ = "Linux"
  elseif (1 == vim.fn.has("win32")) then
    v_0_ = "Windows"
  else
  v_0_ = nil
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["system_name"] = v_0_
  system_name = v_0_
end
local root_path
do
  local v_0_ = (vim.fn.expand("~") .. "/.local/share/nvim/lspinstall/lua-language-server")
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["root_path"] = v_0_
  root_path = v_0_
end
local binary
do
  local v_0_ = (root_path .. "/bin/" .. system_name .. "/lua-language-server")
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["binary"] = v_0_
  binary = v_0_
end
config.bashls.setup(a.merge(global_options, {}))
config.clangd.setup(a.merge(global_options, {}))
config.cmake.setup(a.merge(global_options, {}))
config.sumneko_lua.setup(lua_dev.setup({lspconfig = a.merge(global_options, {cmd = {binary, "-E", (root_path .. "/main.lua")}})}))
config.pyright.setup(a.merge(global_options, {}))
config.r_language_server.setup(a.merge(global_options, {}))
config.rust_analyzer.setup(a.merge(global_options, {}))
config.tsserver.setup(a.merge(global_options, {}))
return config.vuels.setup(a.merge(global_options, {}))