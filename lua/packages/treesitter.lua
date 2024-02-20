---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-refactor",
    "andymass/vim-matchup",
  },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  init = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
  opts = {
    ensure_installed = "all",
    highlight = { enable = true, disable = { "latex", "tmux" } },
    indent = { enable = true },
    format = { enable = true },
    refactor = {
      smart_rename = { enable = true, keymaps = { smart_rename = "<localleader>rn" } },
    },
    matchup = { enable = true },
  },
}
