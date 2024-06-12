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

        vim.keymap.set("n", "ghu", gs.undo_stage_hunk, { buffer = bufnr })

        vim.keymap.set("n", "ghd", gs.preview_hunk, { buffer = bufnr })
        vim.keymap.set("n", "ghp", gs.preview_hunk, { buffer = bufnr })

        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr })
        vim.keymap.set("n", "<leader>tD", gs.toggle_deleted, { buffer = bufnr })

        vim.keymap.set({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { silent = true, buffer = bufnr })
      end,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    config = true,
  },
}
