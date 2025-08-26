---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = {
        enabled = true,
        auto_refresh = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function() vim.b.copilot_suggestion_hidden = true end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function() vim.b.copilot_suggestion_hidden = false end,
      })
    end,
    keys = function()
      local suggestion = require("copilot.suggestion")
      return {
        {
          mode = "i",
          expr = true,
          "<M-Right>",
          function() return suggestion.is_visible() and suggestion.accept() or "<M-Right>" end,
        },
      }
    end,
  },
  {
    "NickvanDyke/opencode.nvim",
    lazy = false,
    ---@module "opencode"
    ---@type opencode.Opts
    opts = {},
    keys = {
      { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode" },
      {
        mode = "n",
        "<leader>oa",
        function() require("opencode").ask("@cursor: ") end,
        desc = "Ask opencode about this",
      },
      {
        mode = "v",
        "<leader>oa",
        function() require("opencode").ask("@selection: ") end,
        desc = "Ask opencode about selection",
      },
    },
  },
}
