" ---------------------------------------------------------------------------- "
" ->                               _            _                           <- "
" ->                  ___ ___   __| | _____   _(_)_ __ ___                  <- "
" ->                 / __/ _ \ / _` |/ _ \ \ / / | '_ ` _ \                 <- "
" ->                | (_| (_) | (_| |  __/\ V /| | | | | | |                <- "
" ->                 \___\___/ \__,_|\___(_)_/ |_|_| |_| |_|                <- "
" ->                                                                        <- "
" ->                          Created by: datwaft                           <- "
" ---------------------------------------------------------------------------- "

" ---------------------------------------------------------------------------- "
" ->                          NeoVim configuration                          <- "
" ---------------------------------------------------------------------------- "
  if has('win32') || has('win64')
    let g:python3_host_prog = '~/AppData/Local/Programs/Python/Python38-32/python.exe'
  else
    let g:python3_host_prog = '/usr/bin/python3'
    let g:python_host_prog = '/usr/bin/python'
  endif
" ---------------------------------------------------------------------------- "
" ->                        Variable initialization                         <- "
" ---------------------------------------------------------------------------- "
  if has('win32') || has('win64')
    let g:plugins_folder = '~/AppData/Local/nvim/plugged'
  else
    let g:plugins_folder = '~/.config/nvim/plugged'
  endif
" ---------------------------------------------------------------------------- "
" ->                           Plugin management                            <- "
" ---------------------------------------------------------------------------- "
  call plug#begin(g:plugins_folder)
    " ------------------ "
    " ↓ Useful plugins ↓ "
    " ------------------ "
      " More targets
      Plug 'wellle/targets.vim'
      " Ability to surround
      Plug 'machakann/vim-sandwich'
  call plug#end()
  filetype plugin indent on
" ---------------------------------------------------------------------------- "
" ->                           Keyboard bindings                            <- "
" ---------------------------------------------------------------------------- "
  " For commenting
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
