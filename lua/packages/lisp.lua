---@type LazySpec
return {
  -- REPL support
  {
    "Olical/conjure",
    ft = { "clojure", "fennel" },
    lazy = true,
    init = function() vim.g["conjure#mapping#doc_word"] = false end,
  },
  -- Parinfer
  { "gpanders/nvim-parinfer" },
}
