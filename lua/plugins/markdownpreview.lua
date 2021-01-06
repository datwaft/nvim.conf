-- ======================
-- COC.NVIM CONFIGURATION
-- ======================
-- Created by datwaft [github.com/datwaft]

return function()
   vim.api.nvim_exec([[
      function OpenBrowser(url)
         call execute('silent exec "!chrome '.a:url.'"')
      endfunction
      let g:mkdp_browserfunc = 'OpenBrowser'
   ]], false)
end
