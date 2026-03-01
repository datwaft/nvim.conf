---@type LazySpec
return {
  -- Language-aware syntax highlighting for diffs
  { "barrettruth/diffs.nvim" },
  -- VSCode-like diff viewer
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
}
