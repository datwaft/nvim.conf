---@type LazySpec
return {
  -- Surround operations
  { "machakann/vim-sandwich", event = "VeryLazy" },
  -- Subversion and coercion operations
  { "tpope/vim-abolish", event = "VeryLazy" },
  -- Undo-tree
  { "mbbill/undotree", event = "VeryLazy" },
  -- Indent and subword text objects
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    keys = {
      -- Indentation
      { mode = { "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>" },
      { mode = { "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>" },
      { mode = { "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>" },
      { mode = { "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>" },
      -- Subword
      { mode = { "o", "x" }, "as", "<cmd>lua require('various-textobjs').subword('outer')<cr>" },
      { mode = { "o", "x" }, "is", "<cmd>lua require('various-textobjs').subword('inner')<cr>" },
    },
  },
  -- Around and inner text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {
      mappings = { around_last = "", inside_last = "" },
    },
  },
  -- Space text objects
  { "vim-utils/vim-space", event = "VeryLazy" },
  -- Paredit
  { "julienvincent/nvim-paredit", event = "VeryLazy", config = true },
  {
    "julienvincent/nvim-paredit-fennel",
    dependencies = { "julienvincent/nvim-paredit" },
    ft = { "fennel" },
    config = true,
  },
  -- Paste images
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    config = true,
    keys = { { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" } },
  },
}
