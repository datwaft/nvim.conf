---@type LazySpec
return {
  {
    "stevearc/quicker.nvim",
    lazy = false,
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      opts = {
        winfixbuf = true,
      },
      keys = {
        { ">", [[<cmd>lua require("quicker").expand()<cr>]] },
        { "<", [[<cmd>lua require("quicker").collapse()<cr>]] },
      },
    },
  },
}
