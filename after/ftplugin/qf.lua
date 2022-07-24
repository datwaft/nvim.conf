local _local_1_ = vim.fn
local line = _local_1_["line"]
local getqflist = _local_1_["getqflist"]
local setqflist = _local_1_["setqflist"]
local _local_2_ = vim
local cmd_21 = _local_2_["cmd"]
local _local_3_ = string
local format = _local_3_["format"]
local _local_4_ = table
local remove = _local_4_["remove"]
local function remove_item()
  local current_item = line(".")
  local current_list = getqflist()
  local new_list
  do
    local _5_ = current_list
    remove(_5_, current_item)
    new_list = _5_
  end
  return setqflist(new_list, "r")
end
vim.keymap.set({"n"}, "<localleader>q", "<cmd>cclose<cr>", {buffer = 0, desc = "<cmd>cclose<cr>"})
return vim.keymap.set({"n"}, "dd", remove_item, {buffer = 0, desc = "remove-item"})