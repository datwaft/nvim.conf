vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.s", "*.S" },
  callback = function()
    vim.opt.filetype = "arm"
  end,
})
