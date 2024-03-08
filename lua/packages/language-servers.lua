---@param self LazyPlugin
---@param opts table
local function config(self, opts)
  local lsp = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Configure some language servers with the default configuration
  for _, server in ipairs({
    "ansiblels",
    "bashls",
    "biome",
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
    "lua_ls",
    "ocamllsp",
    "pyright",
    "r_language_server",
    "rnix",
    "robotframework_ls",
    "ruby_ls",
    "ruff_lsp",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "taplo",
    "vimls",
    "zls",
  }) do
    lsp[server].setup({ capabilities = capabilities })
  end

  -- C languages
  lsp.clangd.setup({
    filetypes = {
      "c",
      "cpp",
      "objc",
      "objcpp",
      "cuda",
    },
    capabilities = capabilities,
  })
  -- Python
  lsp.pyright.setup({
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          ignore = { "*" },
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
  -- VueJS
  lsp.volar.setup({
    ---@param new_config object
    ---@param new_root_dir string
    on_new_config = function(new_config, new_root_dir)
      local util = require("lspconfig.util")

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
      local local_node = util.find_node_modules_ancestor(new_root_dir)

      local global_typescript = global_node .. "/typescript/lib"
      local local_typescript = local_node .. "/typescript/lib"

      if util.path.exists(local_typescript) then
        new_config.init_options.typescript.tsdk = local_typescript
      elseif util.path.exists(global_typescript) then
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
  -- Support LSP file operations
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neo-tree/neo-tree.nvim" },
    config = true,
  },
}
