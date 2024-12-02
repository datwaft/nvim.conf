---@type LazySpec
return {
  -- Fennel
  "jaawerth/fennel.vim",
  -- LaTeX
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_compiler_method = "tectonic"
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_syntax_conceal_disable = 1
    end,
  },
  -- Ansible
  "mfussenegger/nvim-ansible",
  -- ARM ASM
  "ARM9/arm-syntax-vim",
  -- Kitty
  "fladson/vim-kitty",
  -- Brewfile
  "bfontaine/Brewfile.vim",
  -- Jupyter Notebooks
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
  -- Quarto
  {
    "quarto-dev/quarto-nvim",
    lazy = false,
    config = function()
      require("quarto").setup({
        lspFeatures = {
          chunks = "all",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      })
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
    end,
    dependencies = {
      "benlubas/molten-nvim",
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- Jinja
  "Glench/Vim-Jinja2-Syntax",
}
