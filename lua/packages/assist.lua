---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        fennel = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = {
        enabled = true,
        auto_refresh = true,
      },
    },
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
    init = function()
      ---@module "opencode"
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        on_opencode_not_found = function() return false end,
      }
    end,
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
