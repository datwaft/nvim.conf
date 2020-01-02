if has('win32') || has('win64')
  source ~/AppData/Local/nvim/init.vim
else
  source ~/.config/nvim/init.vim
endif

if exists('g:fvim_loaded')
  " good old 'set guifont' compatibility
  " set guifont=Iosevka\ Slab:h16
  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif
