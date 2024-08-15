---@type LazySpec
return {
  -- Enhance commenting
  { "folke/ts-comments.nvim", event = "VeryLazy", config = true },
  -- Surround operations
  { "machakann/vim-sandwich", event = "VeryLazy" },
  -- Subversion and coercion operations
  { "tpope/vim-abolish", event = "VeryLazy" },
  -- Undo-tree
  { "mbbill/undotree", keys = { { "<C-w>u", "<cmd>UndotreeToggle<cr>" } } },
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
    opts = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      return {
        custom_textobjects = {
          s = spec_treesitter({ a = "@statement.outer", i = "@statement.outer" }),
          S = spec_treesitter({ a = "@statement.top", i = "@statement.top" }),
          c = spec_treesitter({ a = "@cell.outer", i = "@cell.inner" }),
        },
      }
    end,
  },
  -- Paste images
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    config = true,
    keys = { { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" } },
  },
}
