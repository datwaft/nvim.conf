---@type LazySpec
return {
  -- Even better fuzzy-finding
  {
    "dmtrKovalenko/fff.nvim",
    lazy = false,
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = {},
    keys = {
      { [[<C-p>]], "<cmd>lua require('fff').find_files()<cr>" },
      { [[<C-l>]], "<cmd>lua require('fff').live_grep()<cr>" },
    },
  },
  -- Fuzzy-finding
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", config = true },
    keys = {
      { [[<C-\>]], "<cmd>lua require('fzf-lua').buffers()<cr>" },
      { [[<F1>]], "<cmd>lua require('fzf-lua').helptags()<cr>" },
      { [[<C-t>]], "<cmd>lua require('fzf-lua').complete_path()<cr>", mode = "i" },
      { [[<C-x><C-f>]], "<cmd>lua require('fzf-lua').complete_path()<cr>", mode = "i" },
    },
    opts = {
      defaults = {
        no_header = true,
        no_header_i = true,
      },
    },
  },
  -- File manipulation
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", config = true },
    config = true,
  },
  -- Sidebar
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons", config = true },
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = "disabled",
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
    },
    keys = {
      { "<C-n>", "<cmd>Neotree<cr>" },
      { "<C-w>f", "<cmd>Neotree toggle<cr>" },
    },
  },
  -- Outline
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-tree/nvim-web-devicons", config = true },
    },
    config = true,
    init = function()
      vim.keymap.set("n", "gO", "<cmd>AerialToggle!<cr>")
    end,
  },
  -- Symbols
  {
    "bassamsdata/namu.nvim",
    opts = {
      namu_symbols = {
        enable = true,
        options = {
          display = {
            padding = 1,
          },
        },
      },
    },
  },
  -- Move between windows and multiplexer panes
  {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    keys = function()
      const ss = require("smart-splits")
      return {
        -- <C-w>+hjkl
        { "<C-w>h", ss.move_cursor_left },
        { "<C-w>j", ss.move_cursor_down },
        { "<C-w>k", ss.move_cursor_up },
        { "<C-w>l", ss.move_cursor_right },
      }
    end,
    opts = {
      mux = {
        backend = {
          "smart-splits-backend-tmux",
          {
            name = "rex",
            protocol_version = "^3.0.0",
            detect = || -> vim.env.REX_SESSION ~= nil and vim.env.REX_BLOCK ~= nil and vim.fn.executable("rex") == 1,
            move = function(direction, opts)
              const command = "smart_splits_move"
              const timeout = 300
              const output = vim.system({
                "rex",
                "do",
                command,
                "--json",
                ("direction=%s"):format(direction),
                ("wrap=%s"):format(tostring(opts?.at_edge == "wrap")),
              }, { text = true }):wait(timeout)
              -- On timeout, `wait()` kills the process and reports exit code 124, or no result if it doesn't finish dying in time
              if output == nil or output.code == 124 and output.signal ~= 0 then
                error(("rex `%s` timed out after %dms"):format(command, timeout))
              end
              if output.code ~= 0 then
                error(("rex `%s` failed (%d): %s"):format(command, output.code, vim.trim(output.stderr)))
              end
              const response = vim.json.decode(output.stdout)
              if type(response) ~= "table" or type(response.handled) ~= "boolean" then
                error(("rex `%s` returned an unexpected response: %s"):format(command, vim.trim(output.stdout)))
              end
              return response.handled
            end,
          },
        },
      },
    },
    dependencies = {
      { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
    },
  },
  -- Stack traces
  { "relf108/nvim-unstack", version = "*", config = true },
}
