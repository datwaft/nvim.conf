---@diagnostic disable: missing-fields
local function config()
  local lsp = require("lspconfig")

  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- Configure some language servers with the default configuration
  for _, server in ipairs({
    "basedpyright",
    "bashls",
    "biome",
    "clangd",
    "cmake",
    "cssls",
    "dockerls",
    "emmet_language_server",
    "html",
    "jdtls",
    "jinja_lsp",
    "lua_ls",
    "ruff",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
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
  -- Fennel
  lsp.fennel_ls.setup({
    root_dir = function(filename, _) return vim.fs.root(filename, { ".git", "flsproject.fnl", "fnl", ".nfnl.fnl" }) end,
    settings = { ["fennel-ls"] = { ["extra-globals"] = "vim icons border" } },
    capabilities = capabilities,
  })
  -- JavaScript
  require("lspconfig.configs").vtsls = require("vtsls").lspconfig
  lsp.vtsls.setup({
    settings = {
      vtsls = { autoUseWorkspaceTsdk = true },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = "literals" },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      typescript = {
        inlayHints = {
          parameterNames = { enabled = "literals" },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
    },
    capabilities = capabilities,

    on_attach = function(client, bufnr) require("twoslash-queries").attach(client, bufnr) end,
  })
  -- VueJS
  lsp.volar.setup({
    ---@param new_config any
    ---@param new_root_dir string
    on_new_config = function(new_config, new_root_dir)
      -- Read file synchronously
      -- See |uv_fs_t|
      ---@param path string
      ---@return string
      local function read_file(path)
        local fd = assert(vim.uv.fs_open(path, "r", 438))
        local stat = assert(vim.uv.fs_fstat(fd))
        local data = assert(vim.uv.fs_read(fd, stat.size))
        assert(vim.uv.fs_close(fd))
        return data
      end

      -- Here we are assuming you are using asdf for managing the global node version
      local tool_versions = read_file(vim.env.HOME .. "/.tool-versions")
      local node_version = tool_versions:match("nodejs (%S+)")

      local global_node = vim.env.HOME .. "/.asdf/installs/nodejs/" .. node_version .. "/lib/node_modules"
      local local_node = vim.fs.dirname(vim.fs.find("node_modules", { path = new_root_dir, upward = true })[1])

      local global_typescript = global_node .. "/typescript/lib"
      local local_typescript = local_node .. "/typescript/lib"

      if vim.uv.fs_stat(local_typescript) then
        new_config.init_options.typescript.tsdk = local_typescript
      elseif vim.uv.fs_stat(global_typescript) then
        new_config.init_options.typescript.tsdk = global_typescript
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
    opts = {
      ui = {
        border = border,
      },
    },
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
      popup = {
        border = border,
      },
    },
  },
}
