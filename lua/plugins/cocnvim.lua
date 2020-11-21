-- ======================
-- COC.NVIM CONFIGURATION
-- ======================
-- Created by datwaft [github.com/datwaft]

require('vimp')

return function()
   -- =====================
   -- Extension declaration
   -- =====================
      vim.g.coc_global_extensions = {
         'coc-explorer',
         'coc-snippets',
         'coc-json',
         'coc-lua',
         'coc-vimlsp',
      }
   -- ====================
   -- Function declaration
   -- ====================
      -- Function to show documentation
      local function show_documentation()
         if vim.fn.index({'vim', 'index'}, vim.bo.filetype) >= 0 then
            vim.cmd [[ execute 'h '.expand('<cword>') ]]
         else
            vim.fn.CocAction('doHover')
         end
      end
   -- ========
   -- Settings
   -- ========
      -- Ability to unload buffers
      vim.o.hidden = true
      -- More space for comands
      vim.o.cmdheight = 2
      -- Less delays
      vim.o.updatetime = 300
      -- Don't show ins-completion-menu messages
      vim.o.shortmess = vim.o.shortmess .. 'c'
      -- Show signcolumn
      do local signcolumn = 'yes'
         vim.o.signcolumn = signcolumn
         vim.wo.signcolumn = signcolumn
      end
      -- Highlight current symbol and references when holding cursor
      vim.cmd [[ autocmd CursorHold * silent call CocActionAsync('highlight') ]]
   -- =================
   -- Keyboard mappings
   -- =================
      -- Navigate diagnostics
      vimp.nmap({'silent'}, '[g', '<Plug>(coc-diagnostic-prev)')
      vimp.nmap({'silent'}, ']g', '<Plug>(coc-diagnostic-next)')
      -- Go-to navigation
      vimp.nmap({'silent'}, 'gd', '<Plug>(coc-definition)')
      vimp.nmap({'silent'}, 'gy', '<Plug>(coc-type-definition)')
      vimp.nmap({'silent'}, 'gi', '<Plug>(coc-implementation)')
      vimp.nmap({'silent'}, 'gr', '<Plug>(coc-references)')
      -- Show documentation in preview window
      vimp.nnoremap({'silent'}, 'K', show_documentation)
      -- Symbol renaming
      vimp.nmap('<leader>rn', '<Plug>(coc-rename)')
      -- Formatting selected code
      vimp.xmap('<leader>f', '<Plug>(coc-format-selected)')
      vimp.nmap('<leader>f', '<Plug>(coc-format-selected)')
      -- Apply code action to the selected region
      vimp.xmap('<leader>a', ' <Plug>(coc-codeaction-selected)')
      vimp.nmap('<leader>a', ' <Plug>(coc-codeaction-selected)')
      -- Quick fix current line
      vimp.nmap('<leader>qf', ' <Plug>(coc-fix-current)')
      -- Selection ranges
      vimp.nmap({'silent'}, '<C-s>', '<Plug>(coc-range-select)')
      vimp.xmap({'silent'}, '<C-s>', '<Plug>(coc-range-select)')
      -- Show diagnostics
      vimp.nnoremap({'silent'}, '<leader>d', ':<C-u>CocList diagnostics<cr>')
   -- ============
   -- Text objects
   -- ============
      -- Inner function
      vimp.xmap('if', '<Plug>(coc-funcobj-i)')
      vimp.omap('if', '<Plug>(coc-funcobj-i)')
      -- Around function
      vimp.xmap('af', '<Plug>(coc-funcobj-a)')
      vimp.omap('af', '<Plug>(coc-funcobj-a)')
      -- Inner class
      vimp.xmap('ic', '<Plug>(coc-classobj-i)')
      vimp.omap('ic', '<Plug>(coc-classobj-i)')
      -- Around class
      vimp.xmap('ac', '<Plug>(coc-classobj-a)')
      vimp.omap('ac', '<Plug>(coc-classobj-a)')
   -- ==================
   -- Command definition
   -- ==================
      -- Format current buffer
      vimp.map_command('Format', function() vim.fn.CocAction('format') end)
      -- Fold current buffer
      vimp.map_command('Fold', function(args) vim.fn.CocAction('format', args) end)
      -- Organize imports of current buffer
      vimp.map_command('OR', function() vim.fn.CocAction('runCommand', 'editor.action.organizeImport') end)
   -- ====================
   -- Plugin configuration
   -- ====================
      -- coc-explorer
      -- ============
         vimp.nmap('<C-n>', [[:CocCommand explorer<CR>]])
      -- coc-vimlsp
      -- ==========
         vim.g.markdown_fenced_languages = {
            'vim',
            'help'
         }
end
