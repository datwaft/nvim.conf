---@type LazySpec
return {
  -- Picker for `vim.ui.select` and image viewer
  {
    "folke/snacks.nvim",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      -- Enhance vim.ui.select
      picker = {},
      -- Enable image viewer
      image = { doc = { enabled = false } },
    },
    ---@param opts snacks.Config
    config = function(_, opts)
      require("snacks").setup(opts)
      table.insert(Snacks.image.terminal.envs(), {
        name = "rex",
        terminal = "rex",
        supported = true,
        placeholders = true,
      })
    end,
  },
}
