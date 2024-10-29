---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      notify_no_formatters = false,
      formatters_by_ft = {
        css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        html = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        jsonc = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        sql = { "sleek" },
        tex = { "latexindent" },
        typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        vue = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        graphql = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_format", "ruff_organize_imports" },
        xml = { "xmlformat" },
        ["*"] = { "injected" },
      },
      formatters = {
        latexindent = { prepend_args = { "-l", "-m", "--logfile=/dev/null" } },
        biome = { require_cwd = true },
        ["biome-check"] = { require_cwd = true },
        sleek = { prepend_args = { "--indent-spaces", "2" } },
        xmlformat = { prepend_args = { "--selfclose" } },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout = 500,
      },
    },
    init = function()
      vim.opt.formatexpr = [[v:lua.require("conform").formatexpr()]]
    end,
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = { "stevearc/conform.nvim", "williamboman/mason.nvim" },
    config = true,
  },
}
