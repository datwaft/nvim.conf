---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = { winbar = { "qf", "neo-tree" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diagnostics",
          symbols = {
            error = vim.g.icons.error,
            warn = vim.g.icons.warn,
            info = vim.g.icons.info,
            hint = vim.g.icons.hint,
          },
        },
      },
      lualine_c = {
        "filename",
        {
          "diff",
          symbols = {
            added = vim.g.icons.added,
            modified = vim.g.icons.modified,
            removed = vim.g.icons.removed,
          },
        },
      },
      lualine_x = {
        "encoding",
        "fileformat",
        "filetype",
      },
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
}
