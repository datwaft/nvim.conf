---@type LazySpec
return {
  "folke/sidekick.nvim",
  lazy = false,
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
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
      function() require("sidekick.cli").focus() end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end,
      mode = { "n", "v" },
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").select_prompt() end,
      mode = { "n", "v" },
      desc = "Sidekick Ask Prompt",
    },
  },
}
