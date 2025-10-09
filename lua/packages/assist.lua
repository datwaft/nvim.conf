---@type LazySpec
return {
  "folke/sidekick.nvim",
  lazy = false,
  ---@type sidekick.Config
  opts = {},
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
      function() require("sidekick.cli").send({ focus = true, msg = "{this}" }) end,
      mode = { "n", "x" },
      desc = "Sidekick Send This",
    },
  },
}
