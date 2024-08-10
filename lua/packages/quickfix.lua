---@type LazySpec
return {
  "stevearc/quicker.nvim",
  lazy = false,
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    opts = {
      winfixbuf = true,
    },
    keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },
  },
}
