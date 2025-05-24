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
-- See <https://stackoverflow.com/a/28674661>
---@param input string
local function split_by_whitespace(input)
  local P, S, C, Cc, Ct = vim.lpeg.P, vim.lpeg.S, vim.lpeg.C, vim.lpeg.Cc, vim.lpeg.Ct

  local function token(id, patt) return Ct(Cc(id) * C(patt)) end

  local singleq = P("'") * ((1 - S("'\r\n\f\\")) + (P("\\") * 1)) ^ 0 * "'"
  local doubleq = P('"') * ((1 - S('"\r\n\f\\')) + (P("\\") * 1)) ^ 0 * '"'

  local white = token("whitespace", S("\r\n\f\t ") ^ 1)
  local word = token("word", (1 - S("' \r\n\f\t\"")) ^ 1)

  local string = token("string", singleq + doubleq)

  local tokens = Ct((string + white + word) ^ 0)

  local output = {}
  local match = assert(tokens:match(input))
  assert(type(match) == "table")
  for _, tok in ipairs(match) do
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

---@type table<string, dap.Adapter>
local adapters = {}
---@type table<string, dap.Configuration>
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
      function(input) coroutine.resume(coro, split_by_whitespace(vim.fn.expand(input or ""))) end
    )
  end)
end

adapters.lldb = {
  name = "lldb",
  type = "executable",
  command = "lldb-vscode",
}
adapters.codelldb = {
  name = "codelldb",
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}
adapters.python = {
  name = "python",
  type = "executable",
  command = "python3",
  args = { "-m", "debugpy.adapter" },
  options = {
    source_filetype = "python",
  },
}

configs.lldb = {
  name = "Launch lldb",
  type = "lldb",
  request = "launch",
  program = find_executable,
  args = get_arguments,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
}
configs.codelldb = {
  name = "Launch codelldb",
  type = "codelldb",
  request = "launch",
  program = find_executable,
  args = get_arguments,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  console = "externalTerminal",
}
configs.python = {
  name = "Launch debugpy",
  type = "python",
  request = "launch",
  program = "${file}",
  console = "externalTerminal",
}
configs.pwa_node = {
  name = "Launch pwa-node",
  type = "pwa-node",
  request = "launch",
  program = "${file}",
  cwd = "${workspaceFolder}",
}

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      -- Configure adapters
      dap.adapters = adapters
      -- Configure configurations
      dap.configurations.c = { configs.codelldb }
      dap.configurations.cpp = { configs.codelldb }
      dap.configurations.rust = { configs.codelldb }
      dap.configurations.python = { configs.python }
      dap.configurations.javascript = { configs.pwa_node }
      dap.configurations.typescript = { configs.pwa_node }
      -- Configure default external terminal
      dap.defaults.fallback.force_external_terminal = true
      dap.defaults.fallback.external_terminal = {
        command = "tmux-auto-split",
        args = { "-d", "-c", "#{pane_current_path}" },
      }
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
      -- Define command for debugging a command line script
      vim.api.nvim_create_user_command("Debug", function(opts)
        local input = split_by_whitespace(vim.fn.expand(opts.args))
        local command = input[1]
        table.remove(input, 1)
        local args = input
        local ft = vim.opt_local.filetype:get()
        if dap.configurations[ft] == nil or dap.configurations[ft][1] == nil then
          vim.notify(("Couldn't find a configuration for ft=%s"):format(ft), vim.log.levels.ERROR)
          return
        end
        dap.run({
          name = dap.configurations[ft][1].name,
          type = dap.configurations[ft][1].type,
          request = dap.configurations[ft][1].request,
          program = command,
          args = args,
          ---@diagnostic disable-next-line: undefined-field
          console = dap.configurations[ft][1].console,
        })
      end, { complete = "file", nargs = "+", desc = "Debug command line script" })
      -- Keybinds
      vim.keymap.set("n", "<localleader>gc", dap.continue)
      vim.keymap.set("n", "<localleader>go", dap.step_over)
      vim.keymap.set("n", "<localleader>gi", dap.step_into)
      vim.keymap.set("n", "<localleader>gO", dap.step_out)
      vim.keymap.set("n", "<localleader>gs", dap.close)
      vim.keymap.set("n", "<localleader>gS", dap.terminate)
      vim.keymap.set("n", "<localleader>tb", dap.toggle_breakpoint)
      vim.keymap.set("n", "<localleader>cb", dap.clear_breakpoints)
      vim.keymap.set(
        "n",
        "<localleader>tl",
        function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end
      )
      vim.keymap.set("n", "<localleader>tc", function() dap.set_breakpoint(vim.fn.input("Condition: "), nil, nil) end)
      vim.keymap.set("n", "<localleader>rl", dap.run_last)
      vim.keymap.set("n", "<localleader>rc", dap.run_to_cursor)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      vim.keymap.set({ "n", "v" }, "<localleader>K", '<cmd>lua require("dapui").eval()<cr>')

      dap.listeners.before.attach.dapui = function() dapui.open() end
      dap.listeners.before.launch.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("winfixbuf-dapui", { clear = true }),
        pattern = {
          "dapui_watches",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
        },
        callback = function() vim.opt_local.winfixbuf = true end,
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
    opts = { automatic_installation = true },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "microsoft/vscode-js-debug",
        version = "*",
        lazy = true,
        build = { "npm install", "npx gulp vsDebugServerBundle", "mv dist out" },
      },
    },
    opts = {
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    },
  },
}
