" Language
set encoding=utf-8
set fileencoding=utf-8

if has('win32') || has('win64')
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:plugged_home = '~/.vim/plugged'
endif

let g:python3_host_prog = 'C:\Users\David\AppData\Local\Programs\Python\Python38\python.exe' 

" Plugins List
call plug#begin(g:plugged_home)
  " UI related
  Plug 'itchyny/lightline.vim'            " status line
  Plug 'mhinz/vim-startify'
  " Better visual guide
  Plug 'Yggdroot/indentLine'
  " Autocomplete
  Plug 'neoclide/coc.nvim', {'branch': 'release'} 
  " Formater
  Plug 'Chiel92/vim-autoformat'
  Plug 'vim-python/python-syntax'
  " Themes
  Plug 'dikiaap/minimalist'
  Plug 'chriskempson/base16-vim'
  Plug 'rakr/vim-one'
  Plug 'morhetz/gruvbox'
  " Utilities
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
  Plug 'kshenoy/vim-signature'
  Plug 'wellle/targets.vim'
  Plug 'scrooloose/nerdtree'
  " LaTeX
  Plug 'lervag/vimtex'
  Plug 'Konfekt/FastFold'
  Plug 'matze/vim-tex-fold'
call plug#end()

filetype plugin indent on

" UI configuration
syntax on
syntax enable

" colorscheme
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='light'
colorscheme gruvbox
set background=dark

" True Color Support if available
set termguicolors

set number
set relativenumber

" Keyboard mapping
map <C-c> :NERDTreeToggle<CR> 
noremap <F3> :Autoformat<CR>
inoremap jj <ESC>
inoremap jk <ESC>
inoremap kj <ESC>
inoremap  ¿
tnoremap <Esc> <C-\><C-n>
" Ctrl + a to go to the beginning of the line
map <C-a> ^
imap <C-a> <ESC>I
" Ctrl + s to go to the beginning of the line
map <C-s> $
imap <C-s> <ESC>A
" Makes Enter work in normal mode
nmap <CR> o<ESC>

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Search configuration
set ignorecase
set smartcase

" Tab and Indent configuration
augroup expandtabFTW
    autocmd!
    autocmd FileType * setlocal expandtab
    autocmd FileType * setlocal tabstop=2
    autocmd FileType * setlocal softtabstop=2
    autocmd FileType * setlocal shiftwidth=2
augroup END
set autoindent          " auto indenting

" Undo persistence
set undodir=~/AppData/Local/nvim/undodir.vim
set undofile

" COC.NVIM
source ~/AppData/Local/nvim/coc_configuration.vim

" Vimtex
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
    \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" Assembly filetype configuration
autocmd FileType asm :set ft=tasm

" Format options
set formatoptions+=j
let g:python_highlight_all = 1

" Additional configuration
set backspace=2         " backspace in insert mode works like normal editor
set clipboard+=unnamedplus
set wrap
set textwidth=80

