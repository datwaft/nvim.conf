---@type table<string, table<string, true>>
local get_features_cache = {}
--- Lists all the features of a tree-sitter parser
---@param language string
---@return table<string, true>
local function get_features(language)
  if get_features_cache[language] then return get_features_cache[language] end
  ---@type table<string, true>
  local features = {}
  for _, path in ipairs(vim.api.nvim_get_runtime_file(("queries/%s/*.scm"):format(language), true)) do
    features[vim.fn.fnamemodify(path, ":t:r")] = true
  end
  get_features_cache[language] = features
  return features
end

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
          local bufnr = args.buf
          local language = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
          if not language or language == "tmux" then return end
          local features = get_features(language)
          if features["highlights"] then vim.treesitter.start(bufnr) end
          if features["indents"] then vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()' end
          if features["folds"] then
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
