local _2afile_2a = ".config/nvim.main/fnl/core/plugin/statusline.fnl"
local _0_
do
  local name_0_ = "core.plugin.statusline"
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
local _2amodule_name_2a = "core.plugin.statusline"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
vim.g.bubbly_palette = {background = "#34343c", black = "#3e4249", blue = "#6cb6eb", cyan = "#5dbbc1", darkgrey = "#404247", foreground = "#c5cdd9", green = "#a0c980", lightgrey = "#57595e", purple = "#d38aea", red = "#ec7279", white = "#c5cdd9", yellow = "#deb974"}
vim.g.bubbly_colors = {total_buffer_number = "red"}
vim.g.bubbly_styles = {total_buffer_number = "bold"}
vim.g.bubbly_statusline = {"mode", "truncate", "path", "branch", "lsp_status.diagnostics", "lsp_status.messages", "divisor", "total_buffer_number", "filetype", "progress"}
vim.g.bubbly_filter = {branch = {"fern", "packer"}, filetype = {"fern", "packer"}, path = {"fern", "packer"}, total_buffer_number = {"fern", "packer"}}
return nil