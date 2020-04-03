" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║            o8o               o8o      .                    o8o                               ║ "
" ║            `"'               `"'    .o8                    `"'                               ║ "
" ║           oooo  ooo. .oo.   oooo  .o888oo     oooo    ooo oooo  ooo. .oo.  .oo.              ║ "
" ║           `888  `888P"Y88b  `888    888        `88.  .8'  `888  `888P"Y88bP"Y88b             ║ "
" ║            888   888   888   888    888         `88..8'    888   888   888   888             ║ "
" ║            888   888   888   888    888 . .o.    `888'     888   888   888   888             ║ "
" ║           o888o o888o o888o o888o   '888' Y8P     `8'     o888o o888o o888o o888o            ║ "
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
  set modifiable
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                      Plugin management                                       ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  call plug#begin(g:plugins_folder)
    " ┌──────────────────────────────────────────────────────────────────────────────────────────┐ "
    " │                                    Aesthetic plugins                                     │ "
    " └──────────────────────────────────────────────────────────────────────────────────────────┘ "
      " Colorscheme
      Plug 'morhetz/gruvbox'
      " Status line
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      " Improved search highlight
      Plug 'markonm/traces.vim'
      " Indent guides
      Plug 'Yggdroot/indentLine'
      " Developer icons
      Plug 'ryanoasis/vim-devicons'
      " Display marks
      Plug 'kshenoy/vim-signature'
      " Syntax highlighting
      Plug 'sheerun/vim-polyglot'
      " Semantic highlighting
      Plug 'jaxbot/semantic-highlight.vim'
      " Git
      Plug 'mhinz/vim-signify'
      " Floating terminal
      Plug 'voldikss/vim-floaterm'
    " ┌──────────────────────────────────────────────────────────────────────────────────────────┐ "
    " │                                      Useful plugins                                      │ "
    " └──────────────────────────────────────────────────────────────────────────────────────────┘ "
      " ------------------------------------------------------------------------------------------ "
      " ->                                     Text objects                                     <- "
      " ------------------------------------------------------------------------------------------ "
        " More targets
        Plug 'wellle/targets.vim'
        " Indentation object
        Plug 'michaeljsmith/vim-indent-object'
        " Camel and snake case objects
        Plug 'bkad/CamelCaseMotion'
      " ------------------------------------------------------------------------------------------ "
      " ->                                        Others                                        <- "
      " ------------------------------------------------------------------------------------------ "
        " UndoTree
        Plug 'mbbill/undotree'
        " Ability to comment
        Plug 'tpope/vim-commentary'
        " Ability to surround
        Plug 'machakann/vim-sandwich'
        " Git management
        Plug 'tpope/vim-fugitive'
        " Autocompleter
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        " Filtering and alignment
        Plug 'godlygeek/tabular'
        " Easy quick-scoping
        Plug 'unblevable/quick-scope'
        " Easy swap in function
        Plug 'machakann/vim-swap'
        " Abolish
        Plug 'tpope/vim-abolish'
        " FZF
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'chengzeyi/fzf-preview.vim'
        " Exchange objects
        Plug 'tommcdo/vim-exchange'
    " ┌──────────────────────────────────────────────────────────────────────────────────────────┐ "
    " │                                Language Specific plugins                                 │ "
    " └──────────────────────────────────────────────────────────────────────────────────────────┘ "
      " ------------------------------------------------------------------------------------------ "
      " ->                                       Markdown                                       <- "
      " ------------------------------------------------------------------------------------------ "
        " Document preview
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
      " ------------------------------------------------------------------------------------------ "
      " ->                                         SQL                                          <- "
      " ------------------------------------------------------------------------------------------ "
        " Syntax highlight
        Plug 'shmup/vim-sql-syntax'
      " ------------------------------------------------------------------------------------------ "
      " ->                                         Java                                         <- "
      " ------------------------------------------------------------------------------------------ "
        " Syntax highlight
        Plug 'uiiaoo/java-syntax.vim'
  call plug#end()
  filetype plugin indent on
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                Plugin specific configuration                                 ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        vim-airline                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Enables powerline fonts for airline
    let g:airline_powerline_fonts = 1
    " Sets airline theme to gruvbox
    let g:airline_theme='gruvbox'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                         indentLine                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Uses those characters for every level of indentation.
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    " Excludes those filetypes from having indent lines
    let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'startify', 'fzf']
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                   markdown-preview.nvim                                    │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Opens preview of markdown document with <F5>
    autocmd FileType markdown map <F5> <Plug>MarkdownPreviewToggle
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        vim-polyglot                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " -------------------------------------------------------------------------------------------- "
    " ->                                      vim-markdown                                      <- "
    " -------------------------------------------------------------------------------------------- "
      " LaTeX math
      let g:vim_markdown_math = 1
      " No concealing
      let g:vim_markdown_conceal = 0
      let g:tex_conceal = ""
      let g:vim_markdown_math = 1
      let g:vim_markdown_conceal_code_blocks = 0
      " Strikethough
      let g:vim_markdown_strikethrough = 1
      " Links without .md
      let g:vim_markdown_no_extensions_in_markdown = 1
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          coc.nvim                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " -------------------------------------------------------------------------------------------- "
    " ->                                       Functions                                        <- "
    " -------------------------------------------------------------------------------------------- "
      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction
    " -------------------------------------------------------------------------------------------- "
    " ->                                  Recommended settings                                  <- "
    " -------------------------------------------------------------------------------------------- "
      set hidden
      set updatetime=100
      set shortmess+=c
      set signcolumn=yes
    " -------------------------------------------------------------------------------------------- "
    " ->                                  Extra configurations                                  <- "
    " -------------------------------------------------------------------------------------------- "
      autocmd CursorHold * silent call CocActionAsync('highlight')
      command! -nargs=0 Format :call CocAction('format')
      command! -nargs=? Fold   :call CocAction('fold', <f-args>)
      command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')
    " -------------------------------------------------------------------------------------------- "
    " ->                                         Gotos                                          <- "
    " -------------------------------------------------------------------------------------------- "
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)
    " -------------------------------------------------------------------------------------------- "
    " ->                                         Rename                                         <- "
    " -------------------------------------------------------------------------------------------- "
      nmap <leader>rn <Plug>(coc-rename)
    " -------------------------------------------------------------------------------------------- "
    " ->                                   Show documentation                                   <- "
    " -------------------------------------------------------------------------------------------- "
      nnoremap <silent> K :call <SID>show_documentation()<CR>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        vim-floaterm                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:floaterm_keymap_new    = '<leader>tn'
    let g:floaterm_keymap_prev   = '<leader>th'
    let g:floaterm_keymap_next   = '<leader>tl'
    let g:floaterm_keymap_toggle = '<leader>tt'
    autocmd User Startified setlocal buflisted
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        quick-scope                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                   semantic-highlight.vim                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    au BufReadPost,BufNewFile,BufWritePost 
      \ *.js,*.html,*.java,*.c,*.cpp,*.h,*.py,*.ts SemanticHighlight
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                      CamelCaseMotion                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:camelcasemotion_key = '<leader>'
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                     Color and Look&Feel                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Colorscheme configuration                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Sets gruvbox to hard contrast
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_contrast_light='hard'
    " Enables italics for gruvbox
    let g:gruvbox_italic=1
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Colorscheme declaration                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Uses gruvbox colorscheme
    colorscheme gruvbox
    " Sets colorscheme to dark mode
    set background=dark
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                      File compatibility                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  set nobackup
  set nowritebackup
  set noswapfile
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                    Terminal configuration                                    ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Mouse support                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Enables mouse support
    set mouse=a
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                    Color compatibility                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Uses extended colors
    set termguicolors
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                     Visual configuration                                     ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Encoding                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set encoding=utf-8
    set fileencoding=utf-8
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        Line numbers                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set number
    set relativenumber
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                    Syntax highlighting                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    if !exists("g:syntax_on")
      syntax enable
    endif
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                    Search highlighting                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set incsearch
    set nohlsearch
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                 Autocompletion configuration                                 ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                   Insert-mode completion                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Function for checking if there is a space behind the cursor.
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    " Using <Tab> for triggering completion and navigating completion list 
    inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<Tab>" :
          \ coc#refresh()
    " Using <Tab>, <UP>, <S-Tab> and <DOWN> for navigating completion list
    inoremap <expr> <UP>    pumvisible() ? "\<C-p>" : "\<UP>"
    inoremap <expr> <DOWN>  pumvisible() ? "\<C-n>" : "\<DOWN>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " Using <space> or <C-X> to confirm completion
    inoremap <silent><expr> <space> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<space>"
    inoremap <silent><expr> <C-X>   pumvisible() ? coc#_select_confirm() : "\<C-g>u\<C-X>"
    " Close the preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Command-mode completion                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Enable wildmenu
    set wildmenu
    " Set wildmenu opening character to <Tab>
    set wildcharm=<Tab>
    " Wildmenu ignores the case
    set wildignorecase
    " Can use <space> to terminate wildmenu
    cnoremap <expr> <space> wildmenumode() ? "\<C-e>" : "\<space>"
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
    set softtabstop=-1
    set tabstop=2
    " Indentation
    set autoindent
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Wrapping                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set wrap
    set textwidth=100
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Search                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set ignorecase
    set smartcase
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Format options                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set formatoptions+=t
    set formatoptions+=c
    set formatoptions+=j
    set formatoptions-=r
    set formatoptions-=o
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Miscellaneous                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Undo persistence
    if has('win32') || has('win64')
      set undodir=~/AppData/Local/nvim/undodir.vim
    else
      set undodir=~/.config/nvim/undodir.vim
    endif
    set undofile
    " Backspace
    set backspace=indent,eol,start
    " Not redrawing while macro is playing
    set lazyredraw
    " Autoread when file changes on disk
    set autoread
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c'
      \ && !bufexists("[Command Line]") | checktime | endif
    " Notification after file change on disk
    autocmd FileChangedShellPost * echohl WarningMsg |
      \ echo "File changed on disk. Buffer reloaded." | echohl None
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                    Autocmd configuration                                     ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  augroup numbertoggle
    autocmd!
    " Change to absolute numbers on insert mode
    au InsertEnter * set norelativenumber
    au InsertLeave * set relativenumber
    " Change to absolute numbers on terminal
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | set nu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | set nonu | endif
  augroup END
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
  " │                                          Terminal                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    tnoremap <Esc> <C-\><C-n>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Folding                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
    nnoremap <space> za
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Movement                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Move vertically without worrying about wrapped lines
    nnoremap <expr> k      ( v:count == 0 ? 'gk' : 'k')
    nnoremap <expr> j      ( v:count == 0 ? 'gj' : 'j')
    nnoremap <expr> <up>   ( v:count == 0 ? 'gk' : '<up>')
    nnoremap <expr> <down> ( v:count == 0 ? 'gj' : '<down>')
    " Move to the beginning or end with H or L
    nnoremap H ^
    nnoremap L $
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Miscellaneous                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Use Y to copy from the cursor to the end
    noremap Y y$
    " Highlight last inserted text
    nnoremap gV `[v`]
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                     Function declaration                                     ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " Execute internal command
  funct! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
  endfunct!
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                               Language specific configuration                                ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Assembly                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:asmsyntax='nasm'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                            JSON                                            │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    autocmd FileType json syntax match Comment +\/\/.\+$+
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Markdown                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    autocmd FileType markdown setlocal tabstop=4
    augroup md
      autocmd!
      au BufNewFile,BufRead *.md inoremap <buffer> ;` ```<cr><cr>```<Up><Up>
    augroup END

