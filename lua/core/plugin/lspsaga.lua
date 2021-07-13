local _2afile_2a = ".config/nvim.main/fnl/core/plugin/lspsaga.fnl"
local _0_
do
  local name_0_ = "core.plugin.lspsaga"
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
    return {autoload("vimp"), autoload("lspsaga")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {m = "vimp", plugin = "lspsaga"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local m = _local_0_[1]
local plugin = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin.lspsaga"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
plugin.init_lsp_saga({code_action_keys = {exec = "<CR>", quit = "q"}, code_action_prompt = {enable = true, sign = false, sign_priority = 20, virtual_text = false}, rename_action_keys = {exec = "<CR>", quit = "<M-q>"}})
m.nnoremap({"override", "silent"}, "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>")
m.nnoremap({"override", "silent"}, "<leader>a", "<cmd>lua require'lspsaga.codeaction'.code_action()<cr>")
m.vnoremap({"override", "silent"}, "<leader>a", ":<C-U>lua require'lspsaga.codeaction'.range_code_action()<cr>")
m.nnoremap({"override", "silent"}, "K", "<cmd>lua require'lspsaga.hover'.render_hover_doc()<cr>")
m.nnoremap({"override", "silent"}, "<C-f>", "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<cr>")
m.nnoremap({"override", "silent"}, "<C-b>", "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<cr>")
m.nnoremap({"override", "silent"}, "gs", "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<cr>")
m.nnoremap({"override", "silent"}, "<leader>rn", "<cmd>lua require'lspsaga.rename'.rename()<cr>")
m.nnoremap({"override", "silent"}, "gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<cr>")
m.nnoremap({"override", "silent"}, "<leader>d", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>")
m.nnoremap({"override", "silent"}, "[e", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>")
return m.nnoremap({"override", "silent"}, "]e", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>")