---@type LazySpec
return {
  "yetone/avante.nvim",
  build = "make",
  opts = {
    provider = "gemini",
    providers = {
      ---@module "avante"
      ---@type AvanteProvider
      gemini = {
        api_key_name = "cmd:op read 'op://Private/Gemini API Key/password'",
      },
    },
    behaviour = {
      enable_cursor_planning_mode = true,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "Avante" } },
      ft = { "Avante" },
    },
  },
}
