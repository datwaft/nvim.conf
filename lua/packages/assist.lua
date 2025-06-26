---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
          model = "gemini-2.5-flash",
        },
        inline = {
          adapter = "gemini",
          model = "gemini-2.0-flash-lite",
        },
        cmd = {
          adapter = "gemini",
          model = "gemini-2.0-flash-lite",
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:op item get 'Gemini API Key' --reveal --fields password",
            },
          })
        end,
      },
    },
    init = function()
      vim.cmd("cabbrev cc CodeCompanion")
      require("packages.assist.fidget-spinner"):init()
    end,
    keys = {
      { mode = { "n", "v" }, "<C-w>c", "<cmd>CodeCompanionChat Toggle<cr>" },
      { mode = { "n", "v" }, "<leader>a", "<cmd>CodeCompanionActions<cr>" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "codecompanion" },
        opts = {
          html = {
            enabled = true,
            tag = {
              buf = { icon = " ", highlight = "CodeCompanionChatVariable" },
              file = { icon = " ", highlight = "CodeCompanionChatVariable" },
              help = { icon = "󰘥 ", highlight = "CodeCompanionChatVariable" },
              image = { icon = " ", highlight = "CodeCompanionChatVariable" },
              symbols = { icon = " ", highlight = "CodeCompanionChatVariable" },
              url = { icon = "󰖟 ", highlight = "CodeCompanionChatVariable" },
              var = { icon = " ", highlight = "CodeCompanionChatVariable" },
              tool = { icon = " ", highlight = "CodeCompanionChatTool" },
              user_prompt = { icon = " ", highlight = "CodeCompanionChatTool" },
              prompt = { icon = " ", highlight = "CodeCompanionChatTool" },
              group = { icon = " ", highlight = "CodeCompanionChatToolGroup" },
            },
          },
        },
      },
      "j-hui/fidget.nvim",
    },
  },
}
