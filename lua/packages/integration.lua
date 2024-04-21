---@type LazySpec
return {
  -- Discord integration
  { "andweeb/presence.nvim", event = "VeryLazy" },
  -- REPL integration
  {
    "jpalardy/vim-slime",
    event = "VeryLazy",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_paste_file = vim.fn.tempname()
      vim.g.slime_default_config = {
        socket_name = vim.fn.split(vim.env.TMUX, ",")[1],
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
    end,
    keys = {
      { mode = "x", "<C-s>", "<Plug>SlimeRegionSend" },
      { mode = "n", "<C-s>", "<Plug>SlimeMotionSend" },
      { mode = "n", "<C-s>s", "<Plug>SlimeLineSend" },
      { mode = "n", "<C-s><C-s>", "<Plug>SlimeLineSend" },
      { mode = "n", "<C-s>c", "<Plug>SlimeConfig" },
    },
  },
  -- TMUX integration
  {
    "mrjones2014/smart-splits.nvim",
    version = ">=1.0.0",
    config = true,
    event = "VeryLazy",
    keys = function()
      local ss = require("smart-splits")
      return {
        { "<A-h>", ss.move_cursor_left },
        { "<A-j>", ss.move_cursor_down },
        { "<A-k>", ss.move_cursor_up },
        { "<A-l>", ss.move_cursor_right },
      }
    end,
  },
}
