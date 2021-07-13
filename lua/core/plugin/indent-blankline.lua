local _2afile_2a = ".config/nvim.main/fnl/core/plugin/indent-blankline.fnl"
local _0_
do
  local name_0_ = "core.plugin.indent-blankline"
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
local _2amodule_name_2a = "core.plugin.indent-blankline"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
vim.g.indent_blankline_char = "\226\148\130"
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {"help", "fern", "packer", "fennel", "markdown"}
vim.g.indent_blankline_buftype_exclude = {"terminal"}
vim.g.indent_blankline_show_current_context = false
vim.g.indent_blankline_context_patterns = {"class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object", "^table", "block", "arguments", "if_statement", "else_clause", "jsx_element", "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement"}
return nil