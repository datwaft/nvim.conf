---@type LazySpec
return {
  -- Create directories when saving if necessary
  "jghauser/mkdir.nvim",
  -- Enhanced sorting
  { "sQVe/sort.nvim", config = true },
  -- Sync spell files
  {
    "micarmst/vim-spellsync",
    init = function()
      -- Defer `SpellSync` until spelling activates.
      vim.g.spellsync_run_at_startup = 0
    end,
  },
  -- Add programming dictionary
  {
    "benelan/vim-dirtytalk",
    -- This is pinned because a bot pushes to master daily.
    commit = "4227b58c4151b7551a5d2185a511d516ad0f782b",
    build = ":DirtytalkUpdate",
  },
  -- Never invalidate undo files
  {
    "kevinhwang91/nvim-fundo",
    event = "BufReadPost",
    build = function()
      require("fundo").install()
    end,
    dependencies = { "kevinhwang91/promise-async" },
    config = true,
  },
  -- Better parentheses match
  "andymass/vim-matchup",
}
