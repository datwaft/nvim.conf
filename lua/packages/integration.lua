---@type LazySpec
return {
  -- REPL integration
  {
    "jpalardy/vim-slime",
    event = "VeryLazy",
    init = function()
      vim.g.slime_target = "tmux"
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
        -- OPT+hjkl
        { "<M-h>", ss.move_cursor_left },
        { "<M-j>", ss.move_cursor_down },
        { "<M-k>", ss.move_cursor_up },
        { "<M-l>", ss.move_cursor_right },
        -- OPT+HJKL
        { "<M-H>", ss.move_cursor_left },
        { "<M-J>", ss.move_cursor_down },
        { "<M-K>", ss.move_cursor_up },
        { "<M-L>", ss.move_cursor_right },
        -- OPT+SHIFT+ARROW
        { "<M-S-Left>", ss.move_cursor_left },
        { "<M-S-Down>", ss.move_cursor_down },
        { "<M-S-Up>", ss.move_cursor_up },
        { "<M-S-Right>", ss.move_cursor_right },
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
  -- Jupyter Kernel
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    keys = {
      { mode = "x", "<localleader>e", ":<C-u>MoltenEvaluateVisual<cr>" },
      { mode = "n", "<C-w>o", "<cmd>noautocmd MoltenEnterOutput<cr>" },
      { mode = "n", "<leader>im", "<cmd>MoltenInit<cr>" },
      { mode = "n", "<localleader>e", "<cmd>MoltenEvaluateOperator<cr>" },
      { mode = "n", "<localleader>ee", "<cmd>MoltenEvaluateLine<cr>" },
      { mode = "n", "<localleader>er", "<cmd>MoltenReevaluateCell<cr>" },
    },
  },
}
