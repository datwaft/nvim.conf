---@type LazySpec
return {
  {
    "arborist-ts/arborist.nvim",
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tree-sitter-folds", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then return end

          if vim.treesitter.query.get(lang, "folds") then
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
    end,
    opts = {
      update_cadence = "weekly",
      ensure_installed = {
        "comment",
        "fennel",
        "ghactions",
        "ghostty",
      },
      overrides = {
        comment = { url = "https://github.com/OXY2DEV/tree-sitter-comment" },
        ghactions = { url = "https://github.com/rmuir/tree-sitter-ghactions" },
      },
    },
  },
}
