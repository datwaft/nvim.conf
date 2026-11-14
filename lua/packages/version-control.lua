---@type LazySpec
return {
  -- Git signs and hunk operations
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      ---@param bufnr number
      on_attach = function(bufnr)
        const gs = require("gitsigns")
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end)
        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
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
  -- Language-aware syntax highlighting for diffs
  "barrettruth/diffs.nvim",
  -- VSCode-like diff viewer
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      keymaps = {
        view = {
          focus_explorer = "<C-n>",
          toggle_explorer = "<C-w>f",
        },
      },
    },
  },
}
