---@type LazySpec
return {
  -- Fennel
  "jaawerth/fennel.vim",
  -- LaTeX
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
  },
  -- KDL
  "imsnif/kdl.vim",
  -- Ansible
  "mfussenegger/nvim-ansible",
  -- Go modules
  "johejo/gomod.vim",
  -- General
  {
    "sheerun/vim-polyglot",
    init = function()
      vim.g.polyglot_disabled = { "fennel", "autoindent", "sensible" }
    end,
  },
}
