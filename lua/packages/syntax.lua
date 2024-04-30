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
}
