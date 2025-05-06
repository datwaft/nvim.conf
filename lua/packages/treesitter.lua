---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "andymass/vim-matchup",
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    init = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.treesitter.language.register("bash", "zsh")
      vim.treesitter.language.register("bash", "sh")
    end,
    opts = {
      ensure_installed = "all",
      highlight = { enable = true, disable = { "tmux" } },
      indent = { enable = true },
      matchup = { enable = true },
    },
  },
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },
}
