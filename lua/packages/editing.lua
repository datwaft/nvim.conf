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
    event = "VeryLazy",
    -- Version locked until https://github.com/nvim-mini/mini.nvim/issues/2006 is fixed.
    commit = "4b5348fac5912f1957f4c012c2e0ab0c4b865386",
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
  -- Multiple cursors
  {
    "jake-stewart/multicursor.nvim",
    config = function(_, opts)
      local mc = require("multicursor-nvim")
      mc.setup(opts)

      -- Add cursor above/below current cursor
      vim.keymap.set({ "n", "x" }, "<M-Up>", function() mc.lineAddCursor(-1) end)
      vim.keymap.set({ "n", "x" }, "<M-Down>", function() mc.lineAddCursor(1) end)

      -- Keybinds enabled only when there are multiple cursors
      mc.addKeymapLayer(function(set_keymap)
        set_keymap({ "n", "x" }, "<M-Left>", mc.prevCursor)
        set_keymap({ "n", "x" }, "<M-Right>", mc.nextCursor)

        set_keymap({ "n", "x" }, "<leader>x", mc.deleteCursor)

        set_keymap("n", "<ESC>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Add cursor using operators
      vim.keymap.set("n", "ga", mc.operator)

      -- Add/remove cursors
      vim.keymap.set({ "n", "x" }, "<C-q>", mc.toggleCursor)

      -- Mouse keybinds
      vim.keymap.set("n", "<C-LeftMouse>", mc.handleMouse)
      vim.keymap.set("n", "<C-LeftDrag>", mc.handleMouseDrag)
      vim.keymap.set("n", "<C-LeftRelease>", mc.handleMouseRelease)

      -- Visual-mode mappings
      vim.keymap.set("x", "I", mc.insertVisual)
      vim.keymap.set("x", "A", mc.appendVisual)
    end,
  },
  -- Increment/decrement
  {
    "monaqa/dial.nvim",
    config = function()
      vim.keymap.set("n", "<C-a>", function() require("dial.map").manipulate("increment", "normal") end)
      vim.keymap.set("n", "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end)
      vim.keymap.set("n", "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end)
      vim.keymap.set("n", "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end)
      vim.keymap.set("v", "<C-a>", function() require("dial.map").manipulate("increment", "visual") end)
      vim.keymap.set("v", "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end)
      vim.keymap.set("v", "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end)
      vim.keymap.set("v", "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end)
    end,
  },
}
