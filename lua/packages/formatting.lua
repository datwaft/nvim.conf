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
      vue = { { "prettierd", "prettier" } },
    },
    formatters = {
      latexindent = { prepend_args = { "-l", "-m" } },
      prettier = {
        ---@param ctx conform.Context
        condition = function(ctx)
          return #vim.fs.find("biome.json", { upward = true, stop = vim.uv.os_homedir(), path = ctx.dirname }) == 0
        end,
      },
      prettierd = {
        ---@param ctx conform.Context
        condition = function(ctx)
          return #vim.fs.find("biome.json", { upward = true, stop = vim.uv.os_homedir(), path = ctx.dirname }) == 0
        end,
      },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      else
        return {
          quiet = true,
          lsp_fallback = true,
          timeout = 500,
        }
      end
    end,
  },
  init = function()
    vim.opt.formatexpr = [[v:lua.require("conform").formatexpr()]]
    -- Add commands to toggle format on save
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "Disable format on save", bang = true })
    vim.api.nvim_create_user_command("FormatEnable", function(args)
      if args.bang then
        vim.b.disable_autoformat = false
      else
        vim.g.disable_autoformat = false
      end
    end, { desc = "Enable format on save", bang = true })
    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end
    end, { desc = "Toggle format on save", bang = true })
  end,
}
