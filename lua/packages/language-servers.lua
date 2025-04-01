---@diagnostic disable: missing-fields
local function config()
  local lsp = require("lspconfig")

  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- Configure some language servers with the default configuration
  for _, server in ipairs({
    "bashls",
    "biome",
    "clangd",
    "cmake",
    "cssls",
    "dockerls",
    "html",
    "jdtls",
    "jinja_lsp",
    "lua_ls",
    "ruff",
    "rust_analyzer",
    "svelte",
    "taplo",
    "vimls",
    "zls",
  }) do
    lsp[server].setup({ capabilities = capabilities })
  end

  -- Python
  lsp.basedpyright.setup({
    -- See https://docs.basedpyright.com/v1.28.1/configuration/language-server-settings/#based-settings
    settings = {
      basedpyright = {
        analysis = {
          inlayHints = {
            callArgumentNames = false,
          },
        },
      },
    },
    capabilities = capabilities,
  })
  -- LaTeX
  lsp.texlab.setup({
    settings = {
      texlab = {
        build = {
          executable = "tectonic",
          args = {
            "-X",
            "compile",
            "%f",
            "--synctex",
            "--keep-logs",
            "--keep-intermediates",
          },
        },
      },
    },
    capabilities = capabilities,
  })
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
  -- Fennel
  lsp.fennel_ls.setup({
    root_dir = function(filename, _) return vim.fs.root(filename, { ".git", "flsproject.fnl", "fnl", ".nfnl.fnl" }) end,
    settings = { ["fennel-ls"] = { ["extra-globals"] = "vim icons border" } },
    capabilities = capabilities,
  })
  -- JavaScript
  require("lspconfig.configs").vtsls = require("vtsls").lspconfig
  lsp.vtsls.setup({
    settings = { vtsls = { autoUseWorkspaceTsdk = true } },
    capabilities = capabilities,
    on_attach = function(client, bufnr) require("twoslash-queries").attach(client, bufnr) end,
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
        schemas = vim.tbl_extend("error", require("schemastore").yaml.schemas(), {
          ["https://www.artillery.io/schema.json"] = { "*.load-test.yml", "*.load-test.yaml" },
        }),
      },
    },
    capabilities = capabilities,
  })
  -- GitHub Actions
  lsp.gh_actions_ls.setup({
    filetypes = { "yaml.github" },
    capabilities = capabilities,
  })
  -- GraphQL
  lsp.graphql.setup({
    filetypes = { "graphql", "typescript", "javascript", "typescriptreact", "javascriptreact" },
    capabilities = capabilities,
  })
  -- Queries
  lsp.ts_query_ls.setup({
    settings = {
      parser_install_directories = {
        vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/",
      },
      language_retrieval_patterns = {
        "languages/src/([^/]+)/[^/]+\\.scm$",
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
      { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },
      { "DNLHC/glance.nvim", opts = { border = { enable = true } } },
      "b0o/schemastore.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            "luvit-meta/library",
            "lazy.nvim",
          },
        },
        dependencies = {
          { "Bilal2453/luvit-meta", lazy = true },
        },
      },
      "folke/neoconf.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = { automatic_installation = true },
      },
      "yioneko/nvim-vtsls",
      "marilari88/twoslash-queries.nvim",
    },
  },
  -- Automatic installation
  {
    "williamboman/mason.nvim",
    config = true,
  },
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
  },
}
