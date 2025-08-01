---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      vim.treesitter.language.register("bash", "zsh")
      vim.treesitter.language.register("bash", "sh")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then return end

          if vim.treesitter.query.get(lang, "highlights") then vim.treesitter.start(args.buf) end

          if vim.treesitter.query.get(lang, "folds") then
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
    end,
  },
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },
}
