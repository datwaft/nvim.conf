---@type LazySpec
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        disabled_filetypes = {
          winbar = { "qf", "neo-tree", "aerial" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", { "diff", symbols = icons.git }, { "diagnostics", symbols = icons.diagnostic } },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      winbar = {
        lualine_a = { "location" },
        lualine_b = { "progress" },
        lualine_c = { "filename" },
      },
      inactive_winbar = {
        lualine_a = { "location" },
        lualine_b = { "progress" },
        lualine_c = { "filename" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      -- Enhance vim.ui.select
      picker = {},
      -- Display images
      image = { doc = { inline = false, float = false } },
    },
  },
  -- Indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    ---@module "ibl"
    ---@type ibl.config
    opts = { scope = { enabled = false } },
  },
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
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  -- Highlight spaces on selection
  {
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
  },
}
