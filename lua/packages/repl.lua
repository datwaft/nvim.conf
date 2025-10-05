---@type LazySpec
return {
  {
    "milanglacier/yarepl.nvim",
    opts = {
      metas = {
        ipython = {
          cmd = function() return vim.b.repl_ipython_cmd or vim.g.repl_ipython_cmd or "ipython" end,
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("yarepl-keybinds", { clear = true }),
        callback = function()
          if vim.bo.buftype ~= "nofile" then
            vim.keymap.set("x", "<C-s>", "<Plug>(REPLSendVisual)", { buffer = true })
            vim.keymap.set("n", "<C-s>", "<Plug>(REPLSendOperator)", { buffer = true })
            vim.keymap.set("n", "<C-s>s", "<Plug>(REPLSendLine)", { buffer = true })
            vim.keymap.set("n", "<C-s><C-s>", "<Plug>(REPLSendLine)", { buffer = true })
            if vim.b.repl_default or vim.g.repl_default then
              vim.keymap.set(
                "n",
                "<C-s>I",
                ("<Plug>(REPLStart-%s)"):format(vim.b.repl_default or vim.g.repl_default),
                { buffer = true }
              )
            else
              vim.keymap.set("n", "<C-s>I", "<Plug>(REPLStart)", { buffer = true })
            end
          end
        end,
      })
    end,
  },
}
