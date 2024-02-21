---@type LazySpec
return {
  -- Discord integration
  "andweeb/presence.nvim",
  -- LeetCode integration
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
}
