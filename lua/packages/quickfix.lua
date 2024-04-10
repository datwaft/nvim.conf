---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    event = "VeryLazy",
    dependencies = {
      "junegunn/fzf",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "yorickpeterse/nvim-pqf", event = "VeryLazy", config = true },
}
