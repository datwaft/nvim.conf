---@type LazySpec
return {
  -- Enhance vim.ui.select & vim.ui.input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = false },
      select = { backend = { "builtin" } },
    },
  },
  -- Highlight color codes
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      render = "virtual",
      enable_tailwind = true,
    },
  },
  -- Indentation lines
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "VeryLazy", opts = { scope = { enabled = false } } },
  -- Colorscheme colors in devicons
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "catppuccin/nvim", name = "catppuccin" },
    },
    event = "VeryLazy",
    opts = function()
      local theme_colors = require("catppuccin.palettes").get_palette("mocha")
      return {
        colors = theme_colors,
      }
    end,
  },
  -- Highlight NOTE and the like
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  -- Enhanced markdown syntax
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      modes = { "n", "no", "c" },
      hybrid_modes = { "n" },
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = "c"
        end,
      },
    },
  },
}
