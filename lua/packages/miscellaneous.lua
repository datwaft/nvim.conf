---@type LazySpec
return {
  -- Create directories when saving if necessary
  "jghauser/mkdir.nvim",
  -- Enhanced sorting
  { "sQVe/sort.nvim", config = true },
  -- Sync spell files
  "micarmst/vim-spellsync",
  -- Add programming dictionary
  {
    "sak96/vim-dirtytalk",
    build = ":DirtytalkUpdate",
  },
  -- Never invalidate undo files
  {
    "kevinhwang91/nvim-fundo",
    event = "BufReadPost",
    build = function() require("fundo").install() end,
    dependencies = { "kevinhwang91/promise-async" },
    config = true,
  },
  -- Better parentheses match
  "andymass/vim-matchup",
}
