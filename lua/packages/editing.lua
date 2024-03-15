---@type LazySpec
return {
  -- Comment operations
  { "echasnovski/mini.comment", config = true },
  -- Surround operations
  "machakann/vim-sandwich",
  -- Subversion and coercion operations
  "tpope/vim-abolish",
  -- Undo-tree
  "mbbill/undotree",
  -- Indent text object
  "michaeljsmith/vim-indent-object",
  -- CamelCase text object
  {
    "bkad/CamelCaseMotion",
    keys = {
      { "<leader>w", "<Plug>CamelCaseMotion_w", mode = { "n", "v", "o" } },
      { "<leader>b", "<Plug>CamelCaseMotion_b", mode = { "n", "v", "o" } },
      { "<leader>e", "<Plug>CamelCaseMotion_e", mode = { "n", "v", "o" } },
      { "i<leader>w", "<Plug>CamelCaseMotion_ie", mode = { "x", "o" } },
    },
  },
  -- Around and inner text objects
  {
    "echasnovski/mini.ai",
    opts = {
      mappings = { around_last = "", inside_last = "" },
    },
  },
  -- Space text objects
  "vim-utils/vim-space",
  -- Parinfer
  { "eraserhd/parinfer-rust", build = "cargo build --release" },
}
