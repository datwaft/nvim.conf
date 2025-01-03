---@type LazySpec
return {
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    keys = {
      { mode = { "n", "o", "x" }, "m", "<Plug>(leap-forward)" },
      { mode = { "n", "o", "x" }, "M", "<Plug>(leap-backward)" },
      { mode = { "n", "o", "x" }, "gm", "<Plug>(leap-from-window)" },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { mode = { "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "spider-w" },
      { mode = { "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "spider-e" },
      { mode = { "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "spider-b" },
    },
  },
  {
    "aaronik/treewalker.nvim",
    opts = {
      highlight = true,
    },
    keys = {
      { mode = { "n" }, "<S-Up>", "<cmd>Treewalker Up<cr>" },
      { mode = { "n" }, "<S-Down>", "<cmd>Treewalker Down<cr>" },
      { mode = { "n" }, "<S-Left>", "<cmd>Treewalker Left<cr>" },
      { mode = { "n" }, "<S-Right>", "<cmd>Treewalker Right<cr>" },
    },
  },
}
