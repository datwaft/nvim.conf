---@type LazySpec
return {
  -- Enhance vim.ui.select & vim.ui.input
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = { input = { enabled = false } } },
  -- Preview ranges
  {
    "winston0410/range-highlight.nvim",
    event = "VeryLazy",
    dependencies = { "winston0410/cmd-parser.nvim" },
    config = true,
  },
  -- Highlight color codes
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      user_default_options = { mode = "virtualtext", names = false },
    },
  },
  -- Indentation lines
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "VeryLazy", opts = { scope = { enabled = false } } },
}
