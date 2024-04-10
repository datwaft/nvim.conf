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
  -- Add programming dictionary
  {
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
  },
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
  -- Automatic fennel compilation
  { "Olical/nfnl", ft = "fennel" },
}
