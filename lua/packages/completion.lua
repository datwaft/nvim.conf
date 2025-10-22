---@type LazySpec
return {
  -- Completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      cmdline = { enabled = false },
      sources = {
        default = { "ecolog", "lsp", "path", "snippets", "buffer", "dadbod", "lazydev" },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lazy_dev" } },
          ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
          snippets = { should_show_items = function(ctx) return ctx.trigger.initial_kind ~= "trigger_character" end },
          path = { opts = { get_cwd = function() return vim.fn.getcwd() end } },
        },
      },
      keymap = {
        -- Scrolling
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        -- Completion
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<Space>"] = { "accept", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "snippet_forward",
          "select_next",
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "snippet_backward",
          "fallback",
        },
        ["<M-l>"] = {
          function() return require("sidekick").nes_jump_or_apply() end,
          function() return vim.lsp.inline_completion.get() end,
          "fallback",
        },
        ["<M-Right>"] = {
          function() return require("sidekick").nes_jump_or_apply() end,
          function() return vim.lsp.inline_completion.get() end,
          "fallback",
        },
      },
      completion = {
        keyword = { range = "full" },
        list = { selection = { auto_insert = false, preselect = false } },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 100 },
        ghost_text = { enabled = true },
      },
      snippets = {
        preset = "luasnip",
      },
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },
  },
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()

      vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup("clear-snippets-on-mode-change", { clear = true }),
        pattern = { "s:n", "i:*" },
        callback = function(args)
          local luasnip = require("luasnip")
          if luasnip.session.current_nodes[args.buf] and not luasnip.session.jump_active then
            luasnip.unlink_current()
          end
        end,
      })
    end,
  },
}
