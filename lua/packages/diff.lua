---@type LazySpec
return {
  -- Language-aware syntax highlighting for diffs
  { url = "https://forge.barrettruth.com/barrettruth/diffs.nvim" },
  -- VSCode-like diff viewer
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      keymaps = {
        view = {
          focus_explorer = "<C-n>",
          toggle_explorer = "<C-w>f",
        },
      },
    },
  },
}
