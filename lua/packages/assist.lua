---@type LazySpec
return {
  {
    "folke/sidekick.nvim",
    lazy = false,
    ---@type sidekick.Config
    opts = {
      nes = {
        enabled = true,
      },
    },
    keys = {
      {
        "<M-l>",
        function()
          if require("sidekick").nes_jump_or_apply() then return end
          if vim.lsp.inline_completion.get() then return end
          return "<M-l>"
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
        mode = { "i", "n" },
      },
      {
        "<M-Right>",
        function()
          if require("sidekick").nes_jump_or_apply() then return end
          if vim.lsp.inline_completion.get() then return end
          return "<M-Right>"
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
        mode = { "i", "n" },
      },
      {
        "<c-.>",
        || -> require("sidekick.cli").send({ focus = true, msg = "{this}" }),
        mode = { "n", "x" },
        desc = "Sidekick Send This",
      },
    },
    init = || -> vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown" },
      callback = function() vim.b.sidekick_nes = false end,
    }),
  },
  -- Amp CLI Integration
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = { auto_start = true, log_level = "info" },
  },
}
