---@type LazySpec
return {
  -- Enhance commenting
  { "folke/ts-comments.nvim", event = "VeryLazy", config = true },
  -- Surround operations
  {
    "machakann/vim-sandwich",
    config = function()
      ---@param is_open boolean
      function _G.latex_sandwich_bun(is_open)
        if is_open then
          local name = vim.fn.input("LaTeX func: ")
          if name == "" then error("OperatorSandwichCancel") end
          return "\\" .. name .. "{"
        else
          return "}"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex", "latex", "markdown" },
        callback = function()
          vim.fn["sandwich#util#addlocal"]({
            {
              buns = {
                "v:lua.latex_sandwich_bun(v:true)",
                "v:lua.latex_sandwich_bun(v:false)",
              },
              expr = 1,
              input = { "f" },
              kind = { "add", "replace" },
              nesting = 1,
              match_syntax = 1,
            },
            {
              buns = { [[\\\h\k*{]], [[}]] },
              regex = 1,
              input = { "f" },
              kind = { "delete", "replace", "textobj", "query" },
              nesting = 1,
            },
          })
        end,
      })
    end,
  },
  -- Subversion and coercion operations
  { "tpope/vim-abolish", event = "VeryLazy" },
  -- Undo-tree
  { "mbbill/undotree", keys = { { "<C-w>u", "<cmd>UndotreeToggle<cr>" } } },
  -- Print-debugging
  { "andrewferrier/debugprint.nvim", config = true },
  -- Indent and subword text objects
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    keys = {
      -- Indentation
      { mode = { "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>" },
      { mode = { "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>" },
      { mode = { "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>" },
      { mode = { "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>" },
      -- Subword
      { mode = { "o", "x" }, "as", "<cmd>lua require('various-textobjs').subword('outer')<cr>" },
      { mode = { "o", "x" }, "is", "<cmd>lua require('various-textobjs').subword('inner')<cr>" },
    },
  },
  -- Around and inner text objects
  {
    "nvim-mini/mini.ai",
    dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" } },
    opts = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      local spec_argument = require("mini.ai").gen_spec.argument
      return {
        n_lines = 500,
        custom_textobjects = {
          a = spec_argument({
            brackets = { "%b()", "%b[]", "%b{}", "%b<>" },
            exclude_regions = { '%b""', "%b''", "%b()", "%b[]", "%b{}", "%b<>" },
          }),
          s = spec_treesitter({ a = "@statement.outer", i = "@statement.outer" }),
          S = spec_treesitter({ a = "@statement.top", i = "@statement.top" }),
          c = spec_treesitter({ a = "@cell.outer", i = "@cell.inner" }),
        },
      }
    end,
  },
  -- Align text interactively
  {
    "nvim-mini/mini.align",
    config = true,
  },
  -- Paste images
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
    keys = { { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" } },
  },
  -- Join and split
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
}
