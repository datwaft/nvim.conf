vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "go.mod",
  callback = function()
    vim.opt.filetype = "gomod"
  end,
})
