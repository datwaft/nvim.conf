---@type table<string, Adapter>
local adapters = {}
---@type table<string, Configuration[]>
local configs = {}

adapters.lldb = {
  type = "executable",
  command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
  name = "lldb",
}

configs.lldb = {
  {
    name = "Launch LLDB",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    args = {},
  },
}

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    dap.adapters = adapters
    dap.configurations.c = configs.lldb
    dap.configurations.cpp = configs.lldb
    dap.configurations.rust = configs.lldb
  end,
}
