vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.scm",
  callback = function()
    vim.opt.filetype = "query"
  end,
})
