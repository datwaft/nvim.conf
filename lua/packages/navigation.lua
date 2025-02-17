---@type LazySpec
return {
  -- Fuzzy-finding
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", config = true },
    keys = {
      { [[<C-\>]], "<cmd>lua require('fzf-lua').buffers()<cr>" },
      { [[<C-p>]], "<cmd>lua require('fzf-lua').files()<cr>" },
      { [[<C-l>]], "<cmd>lua require('fzf-lua').live_grep()<cr>" },
      { [[<C-k>]], "<cmd>lua require('fzf-lua').commands()<cr>" },
      { [[<F1>]], "<cmd>lua require('fzf-lua').helptags()<cr>" },
      { [[<C-t>]], "<cmd>lua require('fzf-lua').complete_path()<cr>", mode = "i" },
      { [[<C-x><C-f>]], "<cmd>lua require('fzf-lua').complete_path()<cr>", mode = "i" },
    },
    opts = {
      defaults = {
        no_header = true,
        no_header_i = true,
      },
      winopts = {
        border = border,
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
}
