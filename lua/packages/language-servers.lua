---@param self LazyPlugin
---@param opts table
local function config(self, opts)
  local lsp = require("lspconfig")

  -- Configure some language servers with the default configuration
  for _, server in ipairs({
    "ansiblels",
    "bashls",
    "clangd",
    "clojure_lsp",
    "cmake",
    "cssls",
    "dockerls",
    "emmet_language_server",
    "eslint",
    "gopls",
    "hls",
    "html",
    "jdtls",
    "lemminx",
    "lua_ls",
    "r_language_server",
    "rnix",
    "ruby_ls",
    "rust_analyzer",
    "svelte",
    "taplo",
    "vimls",
    "volar",
    "zls",
  }) do
    lsp[server].setup({})
  end

  -- Lua
  lsp.lua_ls.setup({
    settings = {
      Lua = {
        telemetry = { enable = false },
        hint = { enable = true },
      },
    },
  })
  -- Python
  lsp.pylsp.setup({
    settings = {
      pylsp = {
        plugins = {
          -- Formatting
          black = { enabled = true },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- Linting
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- Typing
          pylsp_mypy = { enabled = true },
          -- Auto-completion
          jedi_completion = { fuzzy = true },
          -- Import sorting
          pyls_isort = { enabled = true },
        },
      },
    },
  })
  -- JSON
  lsp.jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
  -- YAML
  lsp.yamlls.setup({
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").json.schemas(),
      },
    },
  })
end

---@type LazySpec
return {
  -- Configuration
  {
    "neovim/nvim-lspconfig",
    config = config,
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
      "b0o/schemastore.nvim",
      { "folke/neodev.nvim", config = true },
      "folke/neoconf.nvim",
    },
  },
  -- Typescript
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = true,
  },
  -- Dim unused elements
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    opts = {
      alpha = 0.6,
      blend_color = "#1e1e2e",
    },
  },
  -- Project-local settings
  { "folke/neoconf.nvim", config = true },
}
