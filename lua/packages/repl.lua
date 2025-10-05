---@type LazySpec
return {
  {
    "milanglacier/yarepl.nvim",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("yarepl-keybinds", { clear = true }),
        callback = function()
          if vim.bo.buftype ~= "nofile" then
            vim.keymap.set("x", "<C-s>", "<Plug>(REPLSendVisual)", { buffer = true })
            vim.keymap.set("n", "<C-s>", "<Plug>(REPLSendOperator)", { buffer = true })
            vim.keymap.set("n", "<C-s>s", "<Plug>(REPLSendLine)", { buffer = true })
            vim.keymap.set("n", "<C-s><C-s>", "<Plug>(REPLSendLine)", { buffer = true })
          end
        end,
      })
    end,
  },
}
