---@type LazySpec
return {
  "folke/sidekick.nvim",
  lazy = false,
  ---@type sidekick.Config
  opts = {},
  keys = {
    {
      "<tab>",
      function()
        if require("sidekick").nes_jump_or_apply() then return end
        if vim.lsp.inline_completion.get() then return end
        return "<tab>"
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
      mode = { "i", "n" },
    },
    {
      "<c-.>",
      function() require("sidekick.cli").focus({ name = "codex" }) end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    {
      "<leader>a",
      function() require("sidekick.cli").ask({ name = "codex", focus = true }) end,
      mode = { "n", "v" },
      desc = "Sidekick Ask Prompt",
    },
  },
}
