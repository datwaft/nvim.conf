local configuration
configuration = function()
  vim.g.coc_global_extensions = {
    'coc-marketplace',
    'coc-explorer',
    'coc-snippets'
  }
  return vimp.nmap('<C-n>', [[:CocCommand explorer<CR>]])
end
return configuration
