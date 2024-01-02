---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "junegunn/fzf",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { url = "https://gitlab.com/yorickpeterse/nvim-pqf.git", config = true },
}
