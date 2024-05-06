---@type LazySpec
return {
  -- Fuzzy-finding
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-smart-history.nvim", dependencies = { "tami5/sqlite.lua" } },
      "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("smart_history")
    end,
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>ff", builtin.find_files },
        { "<leader>fg", builtin.live_grep },
        { "<leader>fb", builtin.buffers },
        { "<leader>fh", builtin.help_tags },
        { "<leader>fq", builtin.quickfix },
        { "<leader>fl", builtin.loclist },
        { "z=", builtin.spell_suggest },
      }
    end,
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = actions.which_key,
              ["<Esc>"] = actions.close,
              ["<C-q>"] = actions.smart_send_to_qflist,
              ["<C-k>"] = actions.smart_send_to_loclist,
              ["<M-Up>"] = actions.cycle_history_prev,
              ["<M-Down>"] = actions.cycle_history_next,
            },
          },
          history = {
            path = vim.fn.stdpath("data") .. "/databases/telescope_history.sqlite3",
            limit = 100,
          },
          prompt_prefix = "   ",
          selection_caret = "  ",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("mkdir-databases", { clear = true }),
        callback = function()
          vim.fn.mkdir(vim.fn.stdpath("data") .. "/databases", "p")
        end,
        once = true,
      })
    end,
  },
  -- File manipulation
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },
  -- Sidebar
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
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
      { "<C-n>", "<cmd>Neotree toggle<cr>" },
      { "<C-w>f", "<cmd>Neotree toggle<cr>" },
    },
  },
}
