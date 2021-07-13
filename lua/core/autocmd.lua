local _2afile_2a = ".config/nvim.main/fnl/core/autocmd.fnl"
local _0_
do
  local name_0_ = "core.autocmd"
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
    return {autoload("aniseed.core"), autoload("aniseed.nvim"), autoload("aniseed.string"), (_0_)["aniseed/locals"].autocmd, (_0_)["aniseed/locals"]["process-command"]}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {["require-macros"] = {["core.macros"] = true}, autoload = {a = "aniseed.core", nvim = "aniseed.nvim", s = "aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local s = _local_0_[3]
local autocmd = _local_0_[4]
local process_command = _local_0_[5]
local _2amodule_2a = _0_
local _2amodule_name_2a = "core.autocmd"
do local _ = ({nil, _0_, nil, {{nil}, nil, nil, nil}})[2] end
_G["__autocmd_id"] = 0
local process_command0
do
  local v_0_
  local function process_command1(command)
    if a["string?"](command) then
      return command
    else
      local name
      local function _3_()
        _G["__autocmd_id"] = a.inc(_G.__autocmd_id)
        return _G.__autocmd_id
      end
      name = a.str("__autocmd_", _3_())
      do end (_G)[name] = command
      return ("call v:lua." .. name .. "()")
    end
  end
  v_0_ = process_command1
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["process-command"] = v_0_
  process_command0 = v_0_
end
local autocmd0
do
  local v_0_
  do
    local v_0_0
    local function autocmd1(events, pattern, command)
      local events0
      if a["table?"](events) then
        events0 = events
      else
        events0 = {events}
      end
      local pattern0
      if a["table?"](pattern) then
        pattern0 = pattern
      else
        pattern0 = {pattern}
      end
      local events1 = s.join(",", events0)
      local pattern1 = s.join(",", pattern0)
      return nvim.ex.autocmd(events1, pattern1, process_command0(command))
    end
    v_0_0 = autocmd1
    _0_["autocmd"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["autocmd"] = v_0_
  autocmd0 = v_0_
end
do
  vim.cmd(("augroup " .. "restore-cursor-on-exit" .. "\nautocmd!"))
  autocmd0("VimLeave", "*", "set guicursor=a:ver100-blinkon0")
  vim.cmd("augroup END")
end
do
  vim.cmd(("augroup " .. "resize-splits-on-resize" .. "\nautocmd!"))
  autocmd0("VimResized", "*", "wincmd =")
  vim.cmd("augroup END")
end
do
  vim.cmd(("augroup " .. "read-file-on-disk-change" .. "\nautocmd!"))
  local function _3_()
    if ((vim.fn.mode() ~= "c") and (vim.fn.bufexists("[Command Line]") == 0)) then
      return vim.cmd("checktime")
    end
  end
  autocmd0({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, "*", _3_)
  vim.cmd("augroup END")
end
do
  vim.cmd(("augroup " .. "open-file-on-last-position" .. "\nautocmd!"))
  local function _3_()
    if ((vim.fn.line("'\"") > 1) and (vim.fn.line("'\"") <= vim.fn.line("$"))) then
      return vim.cmd("normal! g'\"")
    end
  end
  autocmd0("BufReadPost", "*", _3_)
  vim.cmd("augroup END")
end
do
  vim.cmd(("augroup " .. "disable-spell-on-filetypes" .. "\nautocmd!"))
  autocmd0("FileType", {"help", "packer"}, "setlocal nospell")
  vim.cmd("augroup END")
end
vim.cmd(("augroup " .. "terminal-options" .. "\nautocmd!"))
autocmd0("TermOpen", "*", "startinsert")
vim.cmd("augroup END")
return nil