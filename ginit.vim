" ---------------------------------------------------------------------------- "
" ->                       _       _ _         _                            <- "
" ->                  __ _(_)_ __ (_) |___   _(_)_ __ ___                   <- "
" ->                 / _` | | '_ \| | __\ \ / / | '_ ` _ \                  <- "
" ->                | (_| | | | | | | |_ \ V /| | | | | | |                 <- "
" ->                 \__, |_|_| |_|_|\__(_)_/ |_|_| |_| |_|                 <- "
" ->                 |___/                                                  <- "
" ->                          Created by: datwaftx                          <- "
" ---------------------------------------------------------------------------- "

" ---------------------------------------------------------------------------- "
" ->                           Pre-initialization                           <- "
" ---------------------------------------------------------------------------- "
set modifiable
" ---------------------------------------------------------------------------- "
" ->                           Sourcing init.vim                            <- "
" ---------------------------------------------------------------------------- "
if has('win32') || has('win64')
  source ~/AppData/Local/nvim/init.vim
else
  source ~/.config/nvim/init.vim
endif
" ---------------------------------------------------------------------------- "
" ->                            Font definition                             <- "
" ---------------------------------------------------------------------------- "
if exists('g:fvim_loaded')
  set guifont=Delugia_Nerd_Font:h16
else
  Guifont Delugia Nerd Font:h9
endif
