local _2afile_2a = ".config/nvim.main/fnl/core/mapping.fnl"
local _0_
do
  local name_0_ = "core.mapping"
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
local _2amodule_name_2a = "core.mapping"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
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