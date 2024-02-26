---@type LazySpec
return {
  -- Discord integration
  "andweeb/presence.nvim",
  -- LeetCode integration
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  -- REPL integration
  {
    "jpalardy/vim-slime",
    lazy = false,
    init = function(self)
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
    lazy = false,
    ---@type fun(self: LazyPlugin, keys: string[]):string|LazyKeys[]|string[])
    keys = function()
      local ss = require("smart-splits")
      return {
        { "<C-w>h", ss.move_cursor_left },
        { "<C-w>j", ss.move_cursor_down },
        { "<C-w>k", ss.move_cursor_up },
        { "<C-w>l", ss.move_cursor_right },
      }
    end,
  },
}
