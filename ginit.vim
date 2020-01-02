source init.vim

if exists('g:fvim_loaded')
  " good old 'set guifont' compatibility
  set guifont=Iosevka\ Slab:h16
  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>
  " other options
  FVimCursorSmoothMove v:true
  FVimCursorSmoothBlink v:true
  FVimCustomTitleBar v:true
  FVimFontAntialias v:true
  FVimFontAutohint v:true
  FVimFontSubpixel v:true
  FVimFontLcdRender v:true
  FVimFontHintLevel 'full'
  FVimFontLineHeight '+1.0' " can be 'default', '14.0', '-1.0' etc.
  FVimFontAutoSnap v:true
endif
