" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                                                                              ║ "
" ║                      o8o               o8o      .                    o8o                     ║ "
" ║                      `"'               `"'    .o8                    `"'                     ║ "
" ║ oooo    ooo  .oooo.o oooo  ooo. .oo.   oooo  .o888oo     oooo    ooo oooo  ooo. .oo.  .oo.   ║ "
" ║  `88.  .8'  d88(  '8 `888  `888P"Y88b  `888    888        `88.  .8'  `888  `888P"Y88bP"Y88b  ║ "
" ║   `88..8'   `"Y88b.   888   888   888   888    888         `88..8'    888   888   888   888  ║ "
" ║    `888'    o.  )88b  888   888   888   888    888 . .o.    `888'     888   888   888   888  ║ "
" ║     `8'     8""888P' o888o o888o o888o o888o   '888" Y8P     `8'     o888o o888o o888o o888o ║ "
" ║                                                                                              ║ "
" ║                                      Created by datwaft                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "

" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                     NeoVim configuration                                     ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  if has('win32') || has('win64')
    let g:python3_host_prog = '~/AppData/Local/Programs/Python/Python38-32/python.exe'
  else
    let g:python3_host_prog = '/usr/bin/python3'
    let g:python_host_prog = '/usr/bin/python'
  endif
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                   Variable initialization                                    ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  if has('win32') || has('win64')
    let g:plugins_folder = '~/AppData/Local/nvim/plugged'
  else
    let g:plugins_folder = '~/.config/nvim/plugged'
  endif
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                      Pre-initialization                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Options                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set modifiable
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                         Functions                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    function! ActivateIf(condition, ...)
      let options = get(a:000, 0, {})
      return a:condition ? options : extend(options, { 'on': [], 'for': [] })
    endfunction
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                      Plugin management                                       ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  call plug#begin(g:plugins_folder)
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Useful plugins                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " +------------------------------------------------------------------------------------------+ "
    " |                                       Text objects                                       | "
    " +------------------------------------------------------------------------------------------+ "
      " More targets
      Plug 'wellle/targets.vim'
      " Indentation object
      Plug 'michaeljsmith/vim-indent-object'
      " Variable segment object
      Plug 'Julian/vim-textobj-variable-segment'
      " User defined objects
      Plug 'kana/vim-textobj-user'
    " +------------------------------------------------------------------------------------------+ "
    " |                                          Others                                          | "
    " +------------------------------------------------------------------------------------------+ "
      " Ability to comment
      Plug 'tpope/vim-commentary'
      " Ability to surround
      Plug 'machakann/vim-sandwich'
      " Filtering and alignment
      Plug 'godlygeek/tabular'
      " Easy swap in function
      Plug 'machakann/vim-swap'
      " Abolish
      Plug 'tpope/vim-abolish'
      " Exchange objects
      Plug 'tommcdo/vim-exchange'
      " Color converter
      Plug 'amadeus/vim-convert-color-to'
  call plug#end()
  filetype plugin indent on
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                  Miscelaneous configuration                                  ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Tabulation & Indentation                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Tabulation
    set expandtab
    set smarttab
    set shiftwidth=0
    set tabstop=2
    " Indentation
    set autoindent
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Wrapping                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Enable wrapping
    set wrap
    set textwidth=100
    set linebreak
    " Better wrapping for long lines with indentation
    set breakindent
    set breakindentopt=shift:2
    set showbreak=↳
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                     Search and replace                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Intelligent search case
    set ignorecase
    set infercase
    set smartcase
    " Always use global substitution
    set gdefault
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Format options                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set formatoptions-=t
    set formatoptions+=c
    set formatoptions+=j
    set formatoptions-=r
    set formatoptions-=o
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                      Keyboard bindings                                       ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                            Tabs                                            │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    map <C-t><up>    :tabr<cr>
    map <C-t>k       :tabr<cr>
    map <C-t><down>  :tabl<cr>
    map <C-t>j       :tabl<cr>
    map <C-t><left>  :tabp<cr>
    map <C-t>h       :tabp<cr>
    map <C-t><right> :tabn<cr>
    map <C-t>l       :tabn<cr>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Splits                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    nmap <C-h> <C-w>h
    nmap <C-j> <C-w>j
    nmap <C-k> <C-w>k
    nmap <C-l> <C-w>l
    nmap <C-w>v :vsplit<cr>
    nmap <C-w>s :split<cr>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Movement                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Move vertically without worrying about wrapped lines
    nnoremap <expr> j      v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j'      : 'gj'
    nnoremap <expr> k      v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k'      : 'gk'
    nnoremap <expr> <up>   v:count ? (v:count > 5 ? "m'" . v:count : '') . '<up>'   : 'gk'
    nnoremap <expr> <down> v:count ? (v:count > 5 ? "m'" . v:count : '') . '<down>' : 'gj'
    inoremap <expr> <up>   v:count ? (v:count > 5 ? "m'" . v:count : '') . '<up>'   : '<C-o>gk'
    inoremap <expr> <down> v:count ? (v:count > 5 ? "m'" . v:count : '') . '<down>' : '<C-o>gj'
    " Move to the beginning or end with H or L
    nnoremap H ^
    nnoremap L $
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Miscellaneous                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Use Y to copy from the cursor to the end
    noremap Y y$
    " Execute macro over visual selection
    xnoremap Q :normal @@<CR>
    nnoremap Q :normal @@<CR>
    " Move lines up and down
    nnoremap <C-up> :m-2<cr>
    nnoremap <C-down> :m+<cr>
