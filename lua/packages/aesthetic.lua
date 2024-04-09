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
          { sign = { namespace = { "dap" }, auto = true }, condition = { builtin.not_empty } },
          { sign = { namespace = { "gitsigns" }, auto = true, wrap = true } },
        },
      }
    end,
  },
  -- Experimental UI enhancements
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        progress = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        inc_rename = false,
        lsp_doc_border = false,
      },
      cmdline = { enabled = false },
      messages = { enabled = false },
      popupmenu = { enabled = false },
      notify = { enabled = false },
    },
  },
}
