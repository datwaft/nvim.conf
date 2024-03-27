---@type LazySpec
return {
  "ggandor/leap.nvim",
  dependencies = "tpope/vim-repeat",
  config = function()
    vim.keymap.set({ "n", "x", "o" }, "m", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x", "o" }, "M", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "x", "o" }, "gm", "<Plug>(leap-from-window)")
  end,
}
