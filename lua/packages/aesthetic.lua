---@type LazySpec
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        disabled_filetypes = { winbar = { "qf", "neo-tree" } },
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
  -- Enhance vim.ui.select & vim.ui.input
  { "stevearc/dressing.nvim", opts = { input = { enabled = false } } },
  -- Preview substitution
  {
    "markonm/traces.vim",
    init = function()
      vim.g.traces_abolish_integration = 1
    end,
  },
  -- Preview ranges
  { "winston0410/range-highlight.nvim", dependencies = { "winston0410/cmd-parser.nvim" }, config = true },
  -- Highlight color codes
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = { mode = "virtualtext", names = false },
    },
  },
  -- Indentation lines
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = { scope = { enabled = false } } },
  -- Status column
  {
    "luukvbaal/statuscol.nvim",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        segments = {
          { sign = { namespace = { "diagnostic" } }, condition = { builtin.not_empty } },
          {
            text = { " ", builtin.lnumfunc, " " },
            condition = { builtin.not_empty, true, builtin.not_empty },
          },
          { sign = { namespace = { "gitsigns" }, auto = true, wrap = true } },
        },
      }
    end,
  },
}
