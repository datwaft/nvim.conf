---@type LazySpec
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      ---@param bufnr number
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        vim.keymap.set("n", "]c", function()
          return vim.wo.diff and vim.cmd.normal({ "]c", bang = true }) or gs.nav_hunk("next")
        end)

        vim.keymap.set("n", "[c", function()
          return vim.wo.diff and vim.cmd.normal({ "[c", bang = true }) or gs.nav_hunk("prev")
        end)

        vim.keymap.set("n", "ghs", gs.stage_hunk, { buffer = bufnr })
        vim.keymap.set("n", "ghS", gs.stage_buffer, { buffer = bufnr })

        vim.keymap.set("n", "ghr", gs.reset_hunk, { buffer = bufnr })
        vim.keymap.set("n", "ghR", gs.reset_buffer, { buffer = bufnr })

        vim.keymap.set("n", "<C-w>p", gs.preview_hunk_inline, { buffer = bufnr })
        vim.keymap.set("n", "<C-w>P", gs.preview_hunk, { buffer = bufnr })

        vim.keymap.set("n", "<C-w>b", gs.blame_line, { buffer = bufnr })
        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr })

        vim.keymap.set({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { silent = true, buffer = bufnr })
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    ---@type fun(): DiffviewConfig
    opts = function()
      local actions = require("diffview.actions")
      return {
        keymaps = {
          view = {
            { "n", "<C-n>", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<C-w>f", actions.toggle_files, { desc = "Toggle the file panel." } },
          },
          file_panel = {
            { "n", "<C-n>", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<C-w>f", actions.toggle_files, { desc = "Toggle the file panel." } },
          },
        },
      }
    end,
  },
}
