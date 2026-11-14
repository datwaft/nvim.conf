---@type LazySpec
return {
  {
    "nvim-mini/mini.diff",
    dependencies = { "datwaft/minidiff-jj.nvim" },
    lazy = false,
    opts = || -> {
      view = { style = "number" },
      source = { require("minidiff_jj").gen_source(), require("mini.diff").gen_source.git() },
      mappings = {
        apply = "gs",
        reset = "gh",
        textobject = "ih",
        goto_first = "[C",
        goto_prev = "[c",
        goto_next = "]c",
        goto_last = "]C",
      },
    },
    keys = {
      { "<leader>tp", || -> require("mini.diff").toggle_overlay(0), desc = "Toggle diff overlay" },
    },
  },
  -- Language-aware syntax highlighting for diffs
  "barrettruth/diffs.nvim",
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
