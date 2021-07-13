local _2afile_2a = ".config/nvim.main/fnl/core/plugin/compe.fnl"
local _0_
do
  local name_0_ = "core.plugin.compe"
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
    return {autoload("aniseed.core"), autoload("vimp"), autoload("compe"), (_0_)["aniseed/locals"]["check-backspace"], (_0_)["aniseed/locals"]["s-tab-complete"], (_0_)["aniseed/locals"]["tab-complete"]}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {a = "aniseed.core", m = "vimp", plugin = "compe"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local m = _local_0_[2]
local plugin = _local_0_[3]
local check_backspace = _local_0_[4]
local s_tab_complete = _local_0_[5]
local tab_complete = _local_0_[6]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.plugin.compe"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
vim.opt.completeopt = {"menuone", "noselect"}
plugin.setup({autocomplete = true, debug = false, documentation = {border = {"", "", "", " ", "", "", "", " "}, max_height = math.floor((vim.o.lines * 0.3)), max_width = 120, min_height = 1, min_width = 60, winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder"}, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, min_length = 1, preselect = "enable", resolve_timeout = 800, source = {buffer = true, calc = true, luasnip = false, nvim_lsp = true, nvim_lua = true, omni = false, path = true, ultisnips = false, vsnip = false}, source_timeout = 200, throttle_time = 80})
m.inoremap({"override", "expr", "silent"}, "<C-Space>", "compe#complete()")
m.inoremap({"override", "expr", "silent"}, "<C-e>", "compe#close('<C-e>')")
m.inoremap({"override", "expr", "silent"}, "<space>", "compe#confirm('<space>')")
m.inoremap({"override", "expr", "silent"}, "<C-f>", "compe#scroll({ 'delta': +4 })")
m.inoremap({"override", "expr", "silent"}, "<C-d>", "compe#scroll({ 'delta': -4 })")
local check_backspace0
do
  local v_0_
  local function check_backspace1()
    local result
    do
      local col = (vim.fn.col(".") - 1)
      result = ((col == 0) or vim.fn.getline("."):sub(col, col):match("%s"))
    end
    if a["nil?"](result) then
      return false
    else
      return result
    end
  end
  v_0_ = check_backspace1
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["check-backspace"] = v_0_
  check_backspace0 = v_0_
end
local tab_complete0
do
  local v_0_
  local function tab_complete1()
    if (vim.fn.pumvisible() == 1) then
      return "<C-n>"
    else
      return "<Tab>"
    end
  end
  v_0_ = tab_complete1
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["tab-complete"] = v_0_
  tab_complete0 = v_0_
end
local s_tab_complete0
do
  local v_0_
  local function s_tab_complete1()
    if (vim.fn.pumvisible() == 1) then
      return "<C-p>"
    else
      return "<S-Tab>"
    end
  end
  v_0_ = s_tab_complete1
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["s-tab-complete"] = v_0_
  s_tab_complete0 = v_0_
end
m.inoremap({"override", "expr", "silent"}, "<Tab>", tab_complete0)
m.snoremap({"override", "expr", "silent"}, "<Tab>", tab_complete0)
m.inoremap({"override", "expr", "silent"}, "<S-Tab>", s_tab_complete0)
return m.snoremap({"override", "expr", "silent"}, "<S-Tab>", s_tab_complete0)