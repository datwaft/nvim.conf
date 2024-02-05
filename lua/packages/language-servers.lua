---@param self LazyPlugin
---@param opts table
local function config(self, opts)
  local lsp = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
    "kotlin_language_server",
    "lemminx",
    "lua_ls",
    "r_language_server",
    "rnix",
    "ruby_ls",
    "rust_analyzer",
    "svelte",
    "taplo",
    "vimls",
    "zls",
  }) do
    lsp[server].setup({ capabilities = capabilities })
  end

  -- Lua
  lsp.lua_ls.setup({
    settings = {
      Lua = {
        telemetry = { enable = false },
        hint = { enable = true },
      },
    },
    capabilities = capabilities,
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
    capabilities = capabilities,
  })
  -- VueJS
  lsp.volar.setup({
    ---@param config object
    ---@param root_dir string
    on_new_config = function(config, root_dir)
      local util = require("lspconfig.util")
      local node_global
      do
        local handle = io.open("npm list -g")
        assert(handle ~= nil)
        node_global = handle:read("*l")
        handle:close()
      end
      ---@type string
      local global_typescript = node_global .. "/node_modules/typescript/lib"
      ---@type string
      local local_typescript
      ---@param path string
      ---@return string | nil
      local function check_dir(path)
        local_typescript = util.path.join(path, "node_modules", "typescript", "lib")
        if util.path.exists(local_typescript) then
          return path
        end
      end
      if util.search_ancestors(root_dir, check_dir) then
        config.init_options.typescript.tsdk = local_typescript
      else
        config.init_options.typescript.tsdk = global_typescript
      end
    end,
  })
  -- JSON
  lsp.jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    capabilities = capabilities,
  })
  -- YAML
  lsp.yamlls.setup({
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
    capabilities = capabilities,
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
      "hrsh7th/cmp-nvim-lsp",
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
