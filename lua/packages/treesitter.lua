---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
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
      highlight = { enable = true, disable = { "tmux" } },
      indent = { enable = true },
      format = { enable = true },
      matchup = { enable = true },
      refactor = {
        smart_rename = { enable = true, keymaps = { smart_rename = "<localleader>rn" } },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["as"] = "@statement.outer",
            ["aS"] = "@statement.top",
            ["ic"] = "@cell.inner",
            ["ac"] = "@cell.outer",
          },
        },
      },
    },
  },
  {
    "datwaft/tree-sitter-corpus",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    build = ":TSUpdate corpus",
  },
}
