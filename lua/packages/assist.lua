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
      function() require("sidekick.cli").send({ name = "codex", focus = true, msg = "{this}" }) end,
      mode = { "n", "x" },
      desc = "Sidekick Ask Prompt",
    },
  },
}
