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
      { "nvim-tree/nvim-web-devicons", config = true },
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
  -- Render images
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
    enabled = function()
      local success = pcall(require, "magick")
      return success
    end,
  },
}
