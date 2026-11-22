---@type LazySpec
return {
  -- LSP default configurations
  "neovim/nvim-lspconfig",
  -- JSON and YAML schemas
  {
    "b0o/schemastore.nvim",
    config = function()
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = vim.tbl_extend("error", require("schemastore").yaml.schemas(), {
              ["https://www.artillery.io/schema.json"] = {
                "*.load-test.yml",
                "*.test.yml",
                "*.load-test.yaml",
                "*.test.yaml",
              },
            }),
          },
        },
      })
    end,
  },
  -- LSP loading notifications
  { "j-hui/fidget.nvim", config = true },
  -- Inspect definitions
  { "DNLHC/glance.nvim", opts = { border = { enable = true } } },
  -- Load Lua types lazily
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { "lazy.nvim" },
    },
  },
  -- Inspect types with // ^?
  {
    "marilari88/twoslash-queries.nvim",
    init = function()
      vim.lsp.config("vtsls", {
        on_attach = function(client, bufnr)
          require("twoslash-queries").attach(client, bufnr)
        end,
      })
    end,
  },
  -- LSP installation
  { "mason-org/mason.nvim", config = true },
  -- Project-local settings
  {
    "mrjones2014/codesettings.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
    config = function(_, opts)
      local codesettings = require("codesettings")
      codesettings.setup(opts)

      ---@param _      lsp.InitializeParams
      ---@param config vim.lsp.ClientConfig
      local function load_local_settings(_, config)
        codesettings.with_local_settings(config.name, config)
      end

      -- Chain servers with their own `before_init` so they don't shadow `"*"`.
      for _, server in ipairs({ "rust_analyzer", "actionsls" }) do
        local prev_before_init = vim.lsp.config[server]?.before_init
        if prev_before_init then
          vim.lsp.config(server, {
            before_init = function(params, config)
              load_local_settings(params, config)
              prev_before_init(params, config)
            end,
          })
        end
      end

      vim.lsp.config("*", {
        before_init = load_local_settings,
      })
    end,
  },
  -- Support LSP file operations
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neo-tree/neo-tree.nvim" },
    config = function()
      const lsp_file_operations = require("lsp-file-operations")
      lsp_file_operations.setup()
      -- Tell servers that the client supports file operations
      vim.lsp.config("*", { capabilities = lsp_file_operations.default_capabilities() })
    end,
  },
  -- Open 'textDocument/documentLink' with gx
  {
    "icholy/lsplinks.nvim",
    config = true,
    lazy = false,
    keys = || -> { { "gx", require("lsplinks").gx } },
  },
  -- Enhance code actions select
  {
    "Chaitanyabsprip/fastaction.nvim",
    ---@module "fastaction"
    ---@type FastActionConfig
    opts = {
      dismiss_keys = { "j", "k", "<c-c>", "q", "<esc>" },
    },
  },
  -- Support for `notebookDocument/*`
  { "datwaft/notebook-lsp.nvim", lazy = false },
}
