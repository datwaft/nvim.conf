return function()
  vim.g.coc_global_extensions = {
    'coc-marketplace',
    'coc-explorer',
    'coc-snippets',
    'coc-lua'
  }
  return vimp.nmap('<C-n>', [[:CocCommand explorer<CR>]])
end
