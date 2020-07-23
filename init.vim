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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Options                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set modifiable
    let g:polyglot_disabled = ['markdown']
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
  " │                                     Aesthetic plugins                                      │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Colorschemes
    Plug 'kyoz/purify', { 'rtp': 'vim' }
    Plug 'nanotech/jellybeans.vim'
    Plug 'nightsense/carbonized'
    " Status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Improved search highlight
    Plug 'markonm/traces.vim'
    " Developer icons
    Plug 'ryanoasis/vim-devicons'
    " Display marks
    Plug 'kshenoy/vim-signature'
    " Syntax highlighting
    Plug 'sheerun/vim-polyglot'
    " Git
    Plug 'mhinz/vim-signify', ActivateIf(executable('git'))
    " Hightlight match tag HTML
    Plug 'gregsexton/MatchTag'
    " Colorizer of color codes
    Plug 'RRethy/vim-hexokinase'
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
      " Camel and snake case objects
      Plug 'bkad/CamelCaseMotion'
    " +------------------------------------------------------------------------------------------+ "
    " |                                     File management                                      | "
    " +------------------------------------------------------------------------------------------+ "
      " File manager
      Plug 'preservim/nerdtree'
      " Quick file search
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
      Plug 'chengzeyi/fzf-preview.vim'
    " +------------------------------------------------------------------------------------------+ "
    " |                                          Others                                          | "
    " +------------------------------------------------------------------------------------------+ "
      " UndoTree
      Plug 'mbbill/undotree'
      " Ability to comment
      Plug 'tpope/vim-commentary'
      " Ability to surround
      Plug 'machakann/vim-sandwich'
      " Git management
      Plug 'tpope/vim-fugitive', ActivateIf(executable('git'))
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
      " Exchange objects
      Plug 'tommcdo/vim-exchange'
      " Color picker
      Plug 'DougBeney/pickachu'
      " Asyncronous execution
      Plug 'skywind3000/asyncrun.vim'
      " Color converter
      Plug 'amadeus/vim-convert-color-to'
      " Tmux integration
      Plug 'christoomey/vim-tmux-navigator'
      " REPL integration
      Plug 'jpalardy/vim-slime'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Language specific plugins                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " +------------------------------------------------------------------------------------------+ "
    " |                                           C++                                            | "
    " +------------------------------------------------------------------------------------------+ "
      " Semantic Highlight
      Plug 'jackguo380/vim-lsp-cxx-highlight'
    " +------------------------------------------------------------------------------------------+ "
    " |                                           Java                                           | "
    " +------------------------------------------------------------------------------------------+ "
      " Syntax highlight
      Plug 'uiiaoo/java-syntax.vim'
    " +------------------------------------------------------------------------------------------+ "
    " |                                     Markdown Pandoc                                      | "
    " +------------------------------------------------------------------------------------------+ "
      " Pandoc support
      Plug 'vim-pandoc/vim-pandoc'
      " Pandoc syntax
      Plug 'vim-pandoc/vim-pandoc-syntax'
      " Live preview
      Plug 'conornewton/vim-pandoc-markdown-preview'
    " +------------------------------------------------------------------------------------------+ "
    " |                                   Cisco configuration                                    | "
    " +------------------------------------------------------------------------------------------+ "
      " Syntax highlight
      Plug 'momota/cisco.vim'
    " +------------------------------------------------------------------------------------------+ "
    " |                                          Proloc                                          | "
    " +------------------------------------------------------------------------------------------+ "
      Plug 'soli/prolog-vim'
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        vim-polyglot                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          coc.nvim                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " +------------------------------------------------------------------------------------------+ "
    " |                                    Global extensions                                     | "
    " +------------------------------------------------------------------------------------------+ "
      let g:coc_global_extensions = [
      \ 'coc-marketplace',
      \ 'coc-pairs',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-html',
      \ 'coc-xml',
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-tsserver',
      \ 'coc-tslint-plugin',
      \ 'coc-java',
      \ 'coc-clangd'
      \ ]
    " +------------------------------------------------------------------------------------------+ "
    " |                                        Functions                                         | "
    " +------------------------------------------------------------------------------------------+ "
      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction
    " +------------------------------------------------------------------------------------------+ "
    " |                                   Recommended settings                                   | "
    " +------------------------------------------------------------------------------------------+ "
      set hidden
      set updatetime=100
      set shortmess+=c
      set signcolumn=yes
    " +------------------------------------------------------------------------------------------+ "
    " |                                   Extra configuration                                    | "
    " +------------------------------------------------------------------------------------------+ "
      " Highlight the symbol and its references when holding the cursor.
      autocmd CursorHold * silent call CocActionAsync('highlight')
      " Format current document
      command! -nargs=0 Format :call CocAction('format')
      " Fold current document
      command! -nargs=? Fold :call CocAction('fold', <f-args>)
      " Organize imports
      command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
    " +------------------------------------------------------------------------------------------+ "
    " |                                     Code navigation                                      | "
    " +------------------------------------------------------------------------------------------+ "
      " GoTo code navigation
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)
      " Navigate diagnostics
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)
    " +------------------------------------------------------------------------------------------+ "
    " |                                        Utilities                                         | "
    " +------------------------------------------------------------------------------------------+ "
      " Rename
      nmap <leader>rn <Plug>(coc-rename)
      " Show documentation
      nnoremap <silent> K :call <SID>show_documentation()<CR>
      " Format selected code
      xmap <leader>f <Plug>(coc-format-selected)
      nmap <leader>f <Plug>(coc-format-selected)
      " Apply codeAction to the selected region
      xmap <leader>a <Plug>(coc-codeaction-selected)
      nmap <leader>a <Plug>(coc-codeaction-selected)
      " codeAction for the current line
      nmap <leader>ac <Plug>(coc-codeaction)
      " Fix current line
      nmap <leader>qf <Plug>(coc-fix-current)
      " Funtion text object
      xmap if <Plug>(coc-funcobj-i)
      xmap af <Plug>(coc-funcobj-a)
      omap if <Plug>(coc-funcobj-i)
      omap af <Plug>(coc-funcobj-a)
      " Use <TAB> to select range
      nmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <TAB> <Plug>(coc-range-select)
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        quick-scope                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                      CamelCaseMotion                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:camelcasemotion_key = '<leader>'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        exchange.vim                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set timeoutlen=250
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          pickachu                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    map <A-c> :Pickachu<CR>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Pandoc                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    augroup pandoc_syntax
      autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    augroup END
    let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
    let g:pandoc#filetypes#pandoc_markdown = 0
    let g:pandoc#syntax#codeblocks#embeds#use = 1
    let g:pandoc#syntax#codeblocks#embeds#langs = [
      \ "ruby",
      \ "sql",
      \ "python",
      \ "cpp"
      \ ]
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Pandoc preview                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:md_pdf_viewer="SumatraPDF"
    let g:md_args = "--syntax-definition=$HOME/.config/nvim/markdown-syntax/cisco.xml
      \ -V mainfont='DejaVu Serif'
      \ -V monofont='DejaVu Sans Mono'
      \ -V geometry:a4paper
      \ -V geometry:margin=2cm"
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                     vim-tmux-navigator                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:tmux_navigator_disable_when_zoomed = 1
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                         vim-slime                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:slime_target = "tmux"
    let g:slime_python_ipython = 1
    nmap <leader>s <Plug>SlimeMotionSend
    nmap <leader>ss <Plug>SlimeLineSend
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          NERDTree                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Shortcut to toggle NERDTree
    map <C-n> :NERDTreeToggle<CR>
    " Close vim if NERDTree is the last window open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                     Color and Look&Feel                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Colorscheme configuration                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Sets airline theme to gruvbox
    let g:airline_theme='bubblegum'
    let g:carbonized_dark_CursorLineNr = 'off'
    let g:carbonized_light_CursorLineNr = 'off'
    let g:carbonized_dark_LineNr = 'off'
    let g:carbonized_light_LineNr = 'off'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Colorscheme declaration                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Uses gruvbox colorscheme
    colorscheme carbonized-dark
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                    Split configuration                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Auto resize splits when window is resized
    autocmd VimResized * wincmd =
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Conceal                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Don't conceal current line
    set concealcursor-=inc
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
    " Using <space> to confirm completion
    if has('patch8.1.1068')
      inoremap <expr> <space> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<space>"
    else
      imap <expr> <space> pumvisible() ? "\<C-y>" : "\<C-g>u\<space>"
    endif
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Spelling                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set spelllang=en,es
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                       Miscellaneous                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Toggle pasting
    set pastetoggle=<F3>
    " Better diffing
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
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
    " Easily jump to another file
    set hidden
    set path+=**
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
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set relativenumber
    " Disable numbers on terminal and begin insert mode
    autocmd TermOpen * setlocal nonumber norelativenumber listchars=
    autocmd TermOpen * startinsert
    autocmd BufEnter,BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  augroup END
  " Better scroll performance
  augroup syntaxSyncMinLines
    autocmd!
    autocmd Syntax * syntax sync minlines=2000
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
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Folding                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    nnoremap <expr> <f2> &foldlevel ? 'zM' :'zR'
    nnoremap <space> za
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
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                       Custom commands                                        ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  command Term execute "bel 5sp | term"
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Prolog                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    au FileType perl set filetype=prolog

