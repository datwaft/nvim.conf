---@type LazySpec
return {
  {
    "milanglacier/minuet-ai.nvim",
    opts = {
      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = { "qf", "neo-tree", "aerial", "Avante", "AvanteInput", "AvanteSelectedFiles" },
        keymap = {
          accept = "<M-right>",
          prev = "<leader>[",
          next = "<leader>]",
          dismiss = "<leader>e",
        },
      },
      provider = "gemini",
      provider_options = {
        gemini = {
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
              thinkingConfig = {
                thinkingBudget = 0,
              },
            },
            safetySettings = {
              {
                category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                threshold = "BLOCK_ONLY_HIGH",
              },
            },
          },
        },
      },
    },
  },
}
