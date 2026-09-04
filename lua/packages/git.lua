---@type LazySpec
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      ---@param bufnr number
      on_attach = function(bufnr)
        const gs = require("gitsigns")
        -- Do not attach for .ipynb files, since these are converted with jupytext.nvim
        if vim.api.nvim_buf_get_name(bufnr):match("%.ipynb$") then return false end
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
}
