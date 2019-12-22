" -------------------------------------------------------------------------------------------------
" NeoVim configuration
" -------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
  let g:python3_host_prog = '~/AppData/Local/Programs/Python/Python38-32/python.exe'
else
  let g:python3_host_prog = '/usr/bin/python3'
  let g:python_host_prog = '/usr/bin/python'
endif
" -------------------------------------------------------------------------------------------------
" Variable initiliazation
" -------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
  let g:vim_folder = '~/AppData/Local/nvim'
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:vim_folder = '~/.config/nvim'
  let g:plugged_home = '~/.config/nvim/plugged'
endif
" -------------------------------------------------------------------------------------------------
" Before initialization
" -------------------------------------------------------------------------------------------------
  " vim-polyglot
  let g:polyglot_disabled = ['python', 'python-indent', 'latex']
" -------------------------------------------------------------------------------------------------
" Plugin declaration
" -------------------------------------------------------------------------------------------------
  call plug#begin(g:plugged_home)
    " Status Line
    Plug 'itchyny/lightline.vim'
    " UI Decoration
    Plug 'mhinz/vim-startify'
    " Autocompleter
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Syntax highlighting
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    Plug 'sheerun/vim-polyglot'
    " Better visual guide
    Plug 'Yggdroot/indentLine'
    Plug 'haya14busa/incsearch.vim'
    " Themes
    Plug 'morhetz/gruvbox'
    " Utilities
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'kshenoy/vim-signature'
    Plug 'wellle/targets.vim'
    " File searching
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    " Autocomment
    Plug 'tpope/vim-commentary'
    " Indentation
    Plug 'Vimjas/vim-python-pep8-indent'
    " LaTeX
    Plug 'lervag/vimtex'
    Plug 'Konfekt/FastFold'
    Plug 'matze/vim-tex-fold'
  call plug#end()
  filetype plugin indent on
" -------------------------------------------------------------------------------------------------
" Plugin configuration
" -------------------------------------------------------------------------------------------------
  " coc.nvim
  set hidden
  set updatetime=300
  set shortmess+=c
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  autocmd CursorHold * silent call CocActionAsync('highlight')
  command! -nargs=0 Format :call CocAction('format')
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
  nmap <silent> gd <Plug>(coc-definition)
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  " incsearch.vim
  set incsearch
  set hlsearch
  let g:incsearch#auto_nohlsearch = 1
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)ap g/ <Plug>(incsearch-stay)
  " vimtex
  let g:tex_flavor  = 'latex'
  let g:tex_conceal = ''
  let g:vimtex_fold_manual = 1
  let g:vimtex_latexmk_continuous = 1
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_general_viewer = 'SumatraPDF'
  let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  " fzf.vim
  let g:fzf_buffers_jump = 1
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_tags_command = 'ctags -R'
  let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" -------------------------------------------------------------------------------------------------
" File compatibility
" -------------------------------------------------------------------------------------------------
  " To avoid garbage and to use vim defaults
  set nobackup
  set nowritebackup
  set noswapfile
  set nocompatible
" -------------------------------------------------------------------------------------------------
" Color and Look&Feel
" -------------------------------------------------------------------------------------------------
  " TrueColor support
  set termguicolors
  " Colorscheme
  let g:gruvbox_contrast_dark = 'hard'
  colorscheme gruvbox
  set background=dark
" -------------------------------------------------------------------------------------------------
" Various configurations
" -------------------------------------------------------------------------------------------------
  " Tabulation and indentation
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set autoindent
  " Undo persistence
  set undodir=~/AppData/Local/nvim/undodir.vim
  set undofile
  " Wrapping
  set wrap 
  set textwidth=100
  set backspace=2
  " Line numbers
  set number
  set relativenumber
  " Search configuration
  set ignorecase
  set smartcase
  " Clipboard
  set clipboard+=unnamedplus
  " Syntax
  syntax on
  syntax enable
  " Encoding
  set encoding=utf-8
  set fileencoding=utf-8
  " Format
  set formatoptions+=j
  " Mouse support
  set mouse=a
" -------------------------------------------------------------------------------------------------
" Keyboard
" -------------------------------------------------------------------------------------------------
  map <C-c> :NERDTreeToggle<CR> 
  inoremap  ¿
  tnoremap <Esc> <C-\><C-n>
  " Ctrl + a to go to the beginning of the line
  map <C-a> ^
  imap <C-a> <ESC>I
  " Ctrl + s to go to the beginning of the line
  map <C-s> $
  imap <C-s> <ESC>A
  " Tabs
  map <C-t><up> :tabr<cr>
  map <C-t>k :tabr<cr>
  map <C-t><down> :tabl<cr>
  map <C-t>j :tabl<cr>
  map <C-t><left> :tabp<cr>
  map <C-t>h :tabp<cr>
  map <C-t><right> :tabn<cr>
  map <C-t>l :tabn<cr>
  " Folding
  nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
" -------------------------------------------------------------------------------------------------
" Language Specific
" -------------------------------------------------------------------------------------------------
  " ASM
  let g:asmsyntax = 'nasm'
  " Python
  au BufNewFile,BufRead *.py set foldmethod=indent
  nnoremap <space> za
