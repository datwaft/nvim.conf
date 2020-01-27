" ---------------------------------------------------------------------------- "
" ->                    _       _ _         _                               <- "
" ->                   (_)_ __ (_) |___   _(_)_ __ ___                      <- "
" ->                   | | '_ \| | __\ \ / / | '_ ` _ \                     <- "
" ->                   | | | | | | |_ \ V /| | | | | | |                    <- "
" ->                   |_|_| |_|_|\__(_)_/ |_|_| |_| |_|                    <- "
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
    " --------------------- "
    " ↓ Aesthetic Plugins ↓ "
    " --------------------- "
      " Start screen
      Plug 'mhinz/vim-startify'
      " Colorscheme
      Plug 'morhetz/gruvbox'
      " Status line
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      " Improved search highlight
      Plug 'haya14busa/incsearch.vim'
      " Indent guides
      Plug 'Yggdroot/indentLine'
      " Developer icons
      Plug 'ryanoasis/vim-devicons'
      " Display marks
      Plug 'kshenoy/vim-signature'
      " Syntax highlighting
      Plug 'sheerun/vim-polyglot'
      " Git
      Plug 'mhinz/vim-signify'
    " ------------------ "
    " ↓ Useful plugins ↓ "
    " ------------------ "
      " Better pasting
      Plug 'sickill/vim-pasta'
      " Ability to comment
      Plug 'tpope/vim-commentary'
      " More targets
      Plug 'wellle/targets.vim'
      " Ability to surround
      Plug 'machakann/vim-sandwich'
      " Git management
      Plug 'tpope/vim-fugitive'
      " Autocompleter
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      " Pair insert.
      Plug 'tmsvg/pear-tree'
    " ----------------------------- "
    " ↓ Language Specific Plugins ↓ "
    " ----------------------------- "
      " Markdown
      Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  call plug#end()
  filetype plugin indent on
" ---------------------------------------------------------------------------- "
" ->                     Plugin specific configuration                      <- "
" ---------------------------------------------------------------------------- "
  " vim-airline
  let g:airline_powerline_fonts = 1
  let g:airline_theme='gruvbox'
  " incsearch.vim
  let g:incsearch#auto_nohlsearch=1
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
  " indentLine
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'startify']
  " startify
  let g:startify_custom_header = startify#center([
  \ '    __        __   _                            _                _         ',
  \ '    \ \      / /__| | ___ ___  _ __ ___   ___  | |__   __ _  ___| | __     ',
  \ '     \ \ /\ / / _ \ |/ __/ _ \| |_ ` _ \ / _ \ | |_ \ / _` |/ __| |/ /     ',
  \ '      \ V  V /  __/ | (_| (_) | | | | | |  __/ | |_) | (_| | (__|   <      ',
  \ '       \_/\_/ \___|_|\___\___/|_| |_| |_|\___| |_.__/ \__,_|\___|_|\_\     ',
  \ '                                                                           ',
  \ '                       _       _                  __ _                     ',
  \ '                    __| | __ _| |___      ____ _ / _| |_                   ',
  \ '                   / _` |/ _` | __\ \ /\ / / _` | |_| __|                  ',
  \ '                  | (_| | (_| | |_ \ V  V / (_| |  _| |_                   ',
  \ '                   \__,_|\__,_|\__| \_/\_/ \__,_|_|  \__|                  ',
  \ '                                                                           ',
  \ ])
  " markdown-preview.nvim
  autocmd FileType markdown map <F5> <Plug>MarkdownPreviewToggle
  " coc.nvim
    " Functions
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
    " Recommended settings
    set hidden
    set updatetime=100
    set shortmess+=c
    " Using <TAB> for triggering completion 
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    " Using <Up>, j, <Down> and k for navigating completion list
    inoremap <expr> <UP> pumvisible() ? "\<C-p>" : "\<UP>"
    inoremap <expr> k pumvisible() ? "\<C-p>" : "\k"
    inoremap <expr> <DOWN> pumvisible() ? "\<C-n>" : "\<DOWN>"
    inoremap <expr> j pumvisible() ? "\<C-n>" : "\j"
    " Using <cr> to confirm completion
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    " Close the preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
    " Extra configurations
    autocmd CursorHold * silent call CocActionAsync('highlight')
    command! -nargs=0 Format :call CocAction('format')
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    " Keybinds
    nmap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> K :call <SID>show_documentation()<CR>
  " pear-tree
  let g:pear_tree_smart_openers = 1
  let g:pear_tree_smart_closers = 1
  let g:pear_tree_smart_backspace = 1
" ---------------------------------------------------------------------------- "
" ->                          Color and Look&Feel                           <- "
" ---------------------------------------------------------------------------- "
  " Colorscheme configuration
  let g:gruvbox_contrast_dark='hard'
  " Colorscheme declaration
  colorscheme gruvbox
  set background=dark
" ---------------------------------------------------------------------------- "
" ->                           File compatibility                           <- "
" ---------------------------------------------------------------------------- "
  set nocompatible
  set nobackup
  set nowritebackup
  set noswapfile
" ---------------------------------------------------------------------------- "
" ->                         Terminal configuration                         <- "
" ---------------------------------------------------------------------------- "
  " Mouse support
  set mouse=a
  " Color compatibility
  set termguicolors
" ---------------------------------------------------------------------------- "
" ->                          Visual configuration                          <- "
" ---------------------------------------------------------------------------- "
  " Encoding
  set encoding=utf-8
  set fileencoding=utf-8
  " Line numbers
  set number
  set relativenumber
  " Syntax highlighting
  if !exists("g:syntax_on")
    syntax enable
  endif
  " Search highlighting
  set incsearch
  set hlsearch
  " Wildmenu
  set wildmenu
  set wildmode=full
" ---------------------------------------------------------------------------- "
" ->                       Miscelaneous configuration                       <- "
" ---------------------------------------------------------------------------- "
  " Tabulation
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  " Indentation
  set autoindent
  " Undo persistence
  if has('win32') || has('win64')
    set undodir=~/AppData/Local/nvim/undodir.vim
  else
    set undodir=~/.config/nvim/undodir.vim
  endif
  set undofile
  " Wrapping
  set wrap
  set textwidth=80
  " Backspace
  set backspace=2
  " Search
  set ignorecase
  set smartcase
  " Format options
  set formatoptions+=t
  set formatoptions+=c
  set formatoptions+=j
  set formatoptions-=r
  set formatoptions-=o
" ---------------------------------------------------------------------------- "
" ->                           Keyboard bindings                            <- "
" ---------------------------------------------------------------------------- "
  " Tabs
  map <C-t><up> :tabr<cr>
  map <C-t>k :tabr<cr>
  map <C-t><down> :tabl<cr>
  map <C-t>j :tabl<cr>
  map <C-t><left> :tabp<cr>
  map <C-t>h :tabp<cr>
  map <C-t><right> :tabn<cr>
  map <C-t>l :tabn<cr>
  " Terminal
  tnoremap <Esc> <C-\><C-n>
  " Folding
  nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
  nnoremap <space> za
" ---------------------------------------------------------------------------- "
" ->                          Function declaration                          <- "
" ---------------------------------------------------------------------------- "
  funct! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
  endfunct!
" ---------------------------------------------------------------------------- "
" ->                    Language specific configuration                     <- "
" ---------------------------------------------------------------------------- "
  " Assembly
  let g:asmsyntax='nasm'

