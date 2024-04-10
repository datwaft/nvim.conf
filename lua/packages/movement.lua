---@type LazySpec
return {
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "m", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "M", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gm", "<Plug>(leap-from-window)")
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { mode = { "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "spider-w" },
      { mode = { "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "spider-e" },
      { mode = { "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "spider-b" },
    },
  },
}
