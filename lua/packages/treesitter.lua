---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    init = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.treesitter.language.register("bash", "zsh")
    end,
    opts = {
      ensure_installed = "all",
      highlight = { enable = true, disable = { "latex", "tmux" } },
      indent = { enable = true },
      format = { enable = true },
      refactor = {
        smart_rename = { enable = true, keymaps = { smart_rename = "<localleader>rn" } },
      },
    },
  },
}
