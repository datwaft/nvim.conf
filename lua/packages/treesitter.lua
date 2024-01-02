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
    vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
    vim.opt.foldenable = false
  end,
  opts = {
    ensure_installed = "all",
    highlight = { enable = true, disable = { "latex" } },
    indent = { enable = true },
    format = { enable = true },
    refactor = {
      smart_rename = { enable = true, keymaps = { smart_rename = "<localleader>rn" } },
    },
    matchup = { enable = true },
  },
}
