---@type LazySpec
return {
  -- TMUX integration
  {
    "mrjones2014/smart-splits.nvim",
    -- version = ">=1.0.0",
    commit = "c697ea84309db323e4da82d29c1f23304e6910be", -- FIXME: remove once https://github.com/mrjones2014/smart-splits.nvim/issues/390 is solved
    config = true,
    lazy = false,
    keys = function()
      local ss = require("smart-splits")
      return {
        -- <C-w>+hjkl
        { "<C-w>h", ss.move_cursor_left },
        { "<C-w>j", ss.move_cursor_down },
        { "<C-w>k", ss.move_cursor_up },
        { "<C-w>l", ss.move_cursor_right },
      }
    end,
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
