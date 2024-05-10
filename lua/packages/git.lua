---@type LazySpec
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      ---@param bufnr number
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        ---@param direction "next"|"prev"
        local function navigate_to_hunk(direction)
          if vim.wo.diff then
            return direction == "next" and "]c" or "[c"
          else
            vim.schedule(direction == "next" and gs.next_hunk or gs.prev_hunk)
            return "<Ignore>"
          end
        end

        vim.keymap.set("n", "[c", function()
          navigate_to_hunk("prev")
        end, { buffer = bufnr })
        vim.keymap.set("n", "]c", function()
          navigate_to_hunk("next")
        end, { buffer = bufnr })

        vim.keymap.set("n", "<leader>hs", gs.stage_hunk)
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
        vim.keymap.set("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        vim.keymap.set("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer)
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
        vim.keymap.set("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end)
        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame)
        vim.keymap.set("n", "<leader>hd", gs.diffthis)
        vim.keymap.set("n", "<leader>hD", function()
          gs.diffthis("~")
        end)
        vim.keymap.set("n", "<leader>tD", gs.toggle_deleted)

        vim.keymap.set({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { silent = true })
      end,
    },
  },
}
