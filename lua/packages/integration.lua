---@type LazySpec
return {
  -- TMUX integration
  {
    "mrjones2014/smart-splits.nvim",
    version = ">=1.0.0",
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
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_virt_lines = true
      vim.g.molten_image_location = "virt"
      vim.g.molten_image_provider = "snacks.nvim"
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.keymap.set("x", "<localleader>e", ":<C-u>MoltenEvaluateVisual<cr>", { silent = true })
      vim.keymap.set("n", "<C-w>o", "<cmd>noautocmd MoltenEnterOutput<cr>", { silent = true })
      vim.keymap.set("n", "<leader>im", "<cmd>MoltenInit<cr>", { silent = true })
      vim.keymap.set("n", "<localleader>E", "<cmd>MoltenEvaluateOperator<cr>", { silent = true })
      vim.keymap.set("n", "<localleader>ee", "<cmd>MoltenEvaluateLine<cr>", { silent = true })
      vim.keymap.set("n", "<localleader>er", "<cmd>MoltenReevaluateCell<cr>", { silent = true })
    end,
  },
}
