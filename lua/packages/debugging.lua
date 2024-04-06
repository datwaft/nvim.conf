---@param lang string
local function treesitter_highlight_for(lang)
  ---@param input string
  return function(input)
    local parser = vim.treesitter.get_string_parser(input, lang)
    local tree = parser:parse()[1]
    local query = assert(vim.treesitter.query.get(lang, "highlights"))
    local highlights = {}
    for id, node in query:iter_captures(tree:root(), input) do
      local _, cstart, _, cend = node:range()
      table.insert(highlights, { cstart, cend, "@" .. query.captures[id] })
    end
    return highlights
  end
end

-- Split input by whitespace taking into account strings
---@param input string
---@source https://stackoverflow.com/a/28674661
local function split_by_whitespace(input)
  local lpeg = require("lpeg")
  local P, S, C, Cc, Ct = lpeg.P, lpeg.S, lpeg.C, lpeg.Cc, lpeg.Ct

  local function token(id, patt)
    return Ct(Cc(id) * C(patt))
  end

  local singleq = P("'") * ((1 - S("'\r\n\f\\")) + (P("\\") * 1)) ^ 0 * "'"
  local doubleq = P('"') * ((1 - S('"\r\n\f\\')) + (P("\\") * 1)) ^ 0 * '"'

  local white = token("whitespace", S("\r\n\f\t ") ^ 1)
  local word = token("word", (1 - S("' \r\n\f\t\"")) ^ 1)

  local string = token("string", singleq + doubleq)

  local tokens = Ct((string + white + word) ^ 0)

  local output = {}
  for _, tok in ipairs(lpeg.match(tokens, input)) do
    if tok[1] ~= "whitespace" then
      if tok[1] == "string" then
        table.insert(output, tok[2]:sub(2, -2))
      else
        table.insert(output, tok[2])
      end
    end
  end
  return output
end

---@type table<string, Adapter>
local adapters = {}
---@type table<string, Configuration[]>
local configs = {}

local function find_executable()
  local dap = require("dap")
  return coroutine.create(function(coro)
    vim.ui.input(
      {
        prompt = "Executable: ",
        default = "./",
        completion = "shellcmd",
        highlight = treesitter_highlight_for("bash"),
      },
      ---@param input? string
      function(input)
        if input == nil or input:match("^%s*$") then
          coroutine.resume(coro, dap.ABORT)
        else
          coroutine.resume(coro, input)
        end
      end
    )
  end)
end

local function get_arguments()
  return coroutine.create(function(coro)
    vim.ui.input(
      {
        prompt = "Arguments: ",
        default = "",
        highlight = treesitter_highlight_for("bash"),
      },
      ---@param input? string
      function(input)
        coroutine.resume(coro, split_by_whitespace(input or ""))
      end
    )
  end)
end

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
    program = find_executable,
    args = get_arguments,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local dap = require("dap")
      -- Configure adapters
      dap.adapters = adapters
      -- Configure configurations
      dap.configurations.c = configs.lldb
      dap.configurations.cpp = configs.lldb
      dap.configurations.rust = configs.lldb
      -- Define signs
      define_sign("DapBreakpoint", icons.debug.breakpoint)
      define_sign("DapBreakpointCondition", icons.debug.condition)
      define_sign("DapLogPoint", icons.debug.log)
      define_sign("DapStopped", icons.debug.stopped)
      define_sign("DapBreakpointRejected", icons.debug.rejected)
      -- Define command for toggling breakpoints
      vim.api.nvim_create_user_command("Breakpoint", function(opts)
        if opts.bang then
          dap.toggle_breakpoint(nil, nil, opts.fargs[1])
        else
          dap.set_breakpoint(nil, nil, opts.fargs[1])
        end
      end, { nargs = "?", bang = true, desc = "Set or toggle a breakpoint" })
      -- Keybinds
      vim.keymap.set("n", "<localleader>gc", dap.continue)
      vim.keymap.set("n", "<localleader>go", dap.step_over)
      vim.keymap.set("n", "<localleader>gi", dap.step_into)
      vim.keymap.set("n", "<localleader>gO", dap.step_out)
      vim.keymap.set("n", "<localleader>tb", dap.toggle_breakpoint)
      vim.keymap.set("n", "<localleader>cb", dap.clear_breakpoints)
      vim.keymap.set("n", "<localleader>tl", function()
        dap.toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end)
      vim.keymap.set("n", "<localleader>rl", dap.run_last)
      vim.keymap.set("n", "<localleader>rc", dap.run_to_cursor)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      vim.keymap.set({ "n", "v" }, "<localleader>K", '<cmd>lua require("dapui").eval()<cr>')

      dap.listeners.before.attach.dapui = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui = function()
        dapui.close()
      end
    end,
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    config = true,
    build = ":TSUpdate dap_repl",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
