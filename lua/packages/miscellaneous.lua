---@type LazySpec
return {
  -- Discover mappings
  { "folke/which-key.nvim", config = true },
  -- Create directories when saving if necessary
  "jghauser/mkdir.nvim",
  -- Enhanced sorting
  { "sQVe/sort.nvim", config = true },
  -- Sync spell files
  "micarmst/vim-spellsync",
  -- Never invalidate undo files
  {
    "kevinhwang91/nvim-fundo",
    build = function()
      require("fundo").install()
    end,
    dependencies = { "kevinhwang91/promise-async" },
    config = true,
  },
  -- Better parentheses match
  "andymass/vim-matchup",
}
