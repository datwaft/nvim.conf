---@type LazySpec
return {
  -- Even better fuzzy-finding
  {
    "dmtrKovalenko/fff.nvim",
    lazy = false,
    build = function() require("fff.download").download_or_build_binary() end,
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
    init = function() vim.keymap.set("n", "gO", "<cmd>AerialToggle!<cr>") end,
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
}
