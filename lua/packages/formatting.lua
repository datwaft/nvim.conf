---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
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
      },
      formatters = {
        latexindent = { prepend_args = { "-l", "-m", "--logfile=/dev/null" } },
        ["biome-check"] = {
          condition = function(_, ctx)
            return #vim.fs.find("biome.json", { upward = true, stop = vim.uv.os_homedir(), path = ctx.dirname }) == 1
          end,
        },
        prettier = {
          condition = function(_, ctx)
            return #vim.fs.find("biome.json", { upward = true, stop = vim.uv.os_homedir(), path = ctx.dirname }) == 0
          end,
        },
        prettierd = {
          condition = function(_, ctx)
            return #vim.fs.find("biome.json", { upward = true, stop = vim.uv.os_homedir(), path = ctx.dirname }) == 0
          end,
        },
      },
      format_on_save = {
        quiet = true,
        lsp_fallback = true,
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
