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
    stopOnEntry = false,
    args = {},
  },
}

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    -- Configure adapters
    dap.adapters = adapters
    -- Configure configurations
    dap.configurations.c = configs.lldb
    dap.configurations.cpp = configs.lldb
    dap.configurations.rust = configs.lldb
    -- Define signs
    vim.fn.sign_define("DapBreakpoint", { text = icons.debug.breakpoint, texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = icons.debug.condition, texthl = "DapBreakpointCondition" })
    vim.fn.sign_define("DapLogPoint", { text = icons.debug.log, texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text = icons.debug.stopped, texthl = "DapStopped" })
    vim.fn.sign_define("DapBreakpointRejected", { text = icons.debug.rejected, texthl = "DapBreakpointRejected" })
  end,
}
