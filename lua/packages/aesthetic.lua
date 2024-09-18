---@type LazySpec
return {
  -- Enhance vim.ui.select
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = false },
      select = { backend = { "builtin" } },
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
  -- Render images
  {
    "3rd/image.nvim",
    dependencies = {
      "leafo/magick",
    },
    config = true,
    enabled = function()
      local success = pcall(require, "magick")
      return success
    end,
  },
}
