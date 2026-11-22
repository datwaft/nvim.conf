---@type LazySpec
return {
  -- Add programming dictionary
  {
    "benelan/vim-dirtytalk",
    -- This is pinned because a bot pushes to master daily.
    commit = "4227b58c4151b7551a5d2185a511d516ad0f782b",
    build = ":DirtytalkUpdate",
  },
}
