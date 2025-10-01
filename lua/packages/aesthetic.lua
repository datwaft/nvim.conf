---@type LazySpec
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "rose-pine",
        globalstatus = true,
        disabled_filetypes = {
          winbar = { "qf", "neo-tree", "aerial", "Avante", "AvanteInput", "AvanteSelectedFiles" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", { "diff", symbols = icons.git }, { "diagnostics", symbols = icons.diagnostic } },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = " ",
              dos = " ",
              mac = " ",
            },
          },
          "filetype",
        },
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
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}
