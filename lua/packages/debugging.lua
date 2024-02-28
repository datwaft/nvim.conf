local function set_adapters()
  local dap = require("dap")
  dap.adapters.lldb = {
    type = "executable",
    command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
    name = "lldb",
  }
end

local function set_config()
  local dap = require("dap")

  local lldb = {
    name = "Launch LLDB",
    type = "lldb",
    request = "launch",
    program = function()
      local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      if path ~= nil and path ~= "" then
        return path
      else
        return dap.ABORT
      end
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = false,
    args = {},
  }

  dap.configurations.c = { lldb }
  dap.configurations.cpp = { lldb }
  dap.configurations.rust = { lldb }
end

local function set_signs()
  vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint" })
  vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DapBreakpointCondition" })
  vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpointRejected" })
  vim.fn.sign_define("DapLogPoint", { text = "󰮔 ", texthl = "DapLogPoint" })
  vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped" })
end

local function set_keymaps()
  local dap = require("dap")
  vim.keymap.set("n", "<leader>Dc", dap.continue)
  vim.keymap.set("n", "<leader>Do", dap.step_over)
  vim.keymap.set("n", "<leader>Di", dap.step_into)
  vim.keymap.set("n", "<leader>DO", dap.step_out)
  vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint)
  vim.keymap.set("n", "<leader>DB", dap.set_breakpoint)
  vim.keymap.set("n", "<leader>Dl", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end)
  vim.keymap.set("n", "<leader>Dr", dap.repl.open)
  vim.keymap.set("n", "<leader>DL", dap.run_last)
end

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      set_adapters()
      set_config()
      set_signs()
      set_keymaps()
    end,
  },
}
