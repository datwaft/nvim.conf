---@type LazySpec
return {
  -- Comment operations
  {
    "numToStr/Comment.nvim",
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = { enable_autocmd = false },
      init = function()
        vim.g.skip_ts_context_commentstring_module = true
      end,
    },
  },
  -- Surround operations
  "machakann/vim-sandwich",
  -- Subversion and coercion operations
  "tpope/vim-abolish",
  -- Undo-tree
  "mbbill/undotree",
  -- Indent and subword text objects
  {
    "chrisgrieser/nvim-various-textobjs",
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
    opts = {
      mappings = { around_last = "", inside_last = "" },
    },
  },
  -- Space text objects
  "vim-utils/vim-space",
  -- Paredit
  { "julienvincent/nvim-paredit", config = true },
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
