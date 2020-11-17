configuration = ->
   -- Global extensions
   vim.g.coc_global_extensions = {
      'coc-marketplace'
      'coc-explorer'
      'coc-snippets'
   }
   -- coc-explorer configuration
   vimp.nmap '<C-n>', [[:CocCommand explorer<CR>]]

return configuration
