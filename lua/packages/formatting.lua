---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      bib = { "bibtext-tidy" },
      css = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      jsonc = { { "prettierd", "prettier" } },
      lua = { "stylua" },
      tex = { "latexindent" },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
    },
    formatters = {
      latexindent = { prepend_args = { "-l", "-m" } },
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
}
