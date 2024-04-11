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
  {
    "romainl/vim-qf",
    init = function()
      vim.keymap.set("n", "<C-q>", "<Plug>(qf_qf_toggle)")
    end,
  },
}
