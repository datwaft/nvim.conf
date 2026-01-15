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
      library = {
        "luvit-meta/library",
        "lazy.nvim",
      },
    },
    dependencies = { { "Bilal2453/luvit-meta", lazy = true } },
  },
  -- Inspect types with // ^?
  {
    "marilari88/twoslash-queries.nvim",
    init = function()
      vim.lsp.config("vtsls", {
        on_attach = function(client, bufnr) require("twoslash-queries").attach(client, bufnr) end,
      })
    end,
  },
  -- LSP installation
  { "mason-org/mason.nvim", config = true },
  -- Project-local settings
  { "folke/neoconf.nvim", config = true },
  -- Support LSP file operations
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neo-tree/neo-tree.nvim" },
    config = true,
  },
  -- Open 'textDocument/documentLink' with gx
  {
    "icholy/lsplinks.nvim",
    config = true,
    lazy = false,
    keys = function() return { { "gx", require("lsplinks").gx } } end,
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
  -- LSP in embedded code
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    init = function()
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = vim.api.nvim_create_augroup("otter-autostart", { clear = true }),
        pattern = { "*.md", "*.ipynb" },
        callback = function()
          local parser = vim.treesitter.get_parser(0)
          if not parser then return end

          local otter = require("otter")
          vim.b.otter_parsers_attached = vim.b.otter_parsers_attached or {}

          local line, column = vim.fn.line(".") - 1, vim.fn.col(".") - 1
          local language = parser:language_for_range({ line, column, line, column + 1 }):lang()
          if language == parser:lang() then return end
          if language == "markdown_inline" then return end
          if not vim.b.otter_parsers_attached[language] then
            vim.b.otter_parsers_attached[language] = true
            vim.schedule(function() otter.activate({ language }, true, true) end)
          end
        end,
      })
    end,
  },
}
