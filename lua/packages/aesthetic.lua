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
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype", "PencilMode" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
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
