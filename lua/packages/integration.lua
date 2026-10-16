---@type LazySpec
return {
  -- Multiplexer integration
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
  -- Database
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = false,
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion" },
      { "tpope/vim-dotenv" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_use_nvim_notify = 1
    end,
    keys = {
      { "<C-w>q", "<cmd>DBUIToggle<cr>" },
    },
  },
}
