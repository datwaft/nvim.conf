---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      vim.treesitter.language.register("bash", "sh")
      vim.treesitter.language.register("fennel", "fnl")
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang or not vim.treesitter.language.add(lang) then return end
          if vim.treesitter.query.get(lang, "highlights") then vim.treesitter.start(args.buf) end
          if vim.treesitter.query.get(lang, "indents") then
            vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
          end
          if vim.treesitter.query.get(lang, "folds") then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
      -- Custom parsers
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          local parsers = require("nvim-treesitter.parsers")
          parsers.bg3_stats = {
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              location = "tree-sitter-bg3-stats",
              queries = "tree-sitter-bg3-stats/queries",
            },
          }
          parsers.bg3_stats_value = {
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              location = "tree-sitter-bg3-stats-value",
              queries = "tree-sitter-bg3-stats-value/queries",
            },
          }
          parsers.bg3_thoth = {
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              location = "tree-sitter-bg3-thoth",
              queries = "tree-sitter-bg3-thoth/queries",
            },
          }
          parsers.bg3_osiris = {
            install_info = {
              url = "https://github.com/datwaft/tree-sitter-bg3",
              location = "tree-sitter-bg3-osiris",
              queries = "tree-sitter-bg3-osiris/queries",
            },
          }
          parsers.ghactions = {
            tier = 1,
            install_info = {
              url = "https://github.com/rmuir/tree-sitter-ghactions",
              revision = "main",
              queries = "queries",
            },
          }
          parsers.tmux = {
            install_info = {
              url = "https://github.com/Freed-Wu/tree-sitter-tmux",
              branch = "main",
              queries = "queries",
            },
          }
          parsers.lua.install_info = {
            url = "https://github.com/datwaft/tree-sitter-lua",
            revision = "main",
            queries = "queries",
          }
          parsers.comment.install_info = {
            url = "https://github.com/OXY2DEV/tree-sitter-comment",
            revision = "main",
            queries = "queries",
          }
        end,
      })
    end,
  },
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },
  { "datwaft/tree-sitter-bg3", lazy = false },
}
