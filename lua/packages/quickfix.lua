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
      highlight = {
        load_buffers = false,
      },
      keys = {
        { ">", [[<cmd>lua require("quicker").expand()<cr>]] },
        { "<", [[<cmd>lua require("quicker").collapse()<cr>]] },
      },
    },
  },
}
