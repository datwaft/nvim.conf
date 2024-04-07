---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = {
        winbar = {
          "qf",
          "neo-tree",
          "dapui_watches",
          "dapui_stacks",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
        },
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostic.error,
            warn = icons.diagnostic.warn,
            info = icons.diagnostic.info,
            hint = icons.diagnostic.hint,
          },
        },
      },
      lualine_c = {
        "filename",
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
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
