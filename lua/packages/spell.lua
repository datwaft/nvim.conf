---@type LazySpec
return {
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
}
