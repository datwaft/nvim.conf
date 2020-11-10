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
  let g:python3_host_prog = '/usr/bin/python3'
  let g:python_host_prog = '/usr/bin/python'
  let g:coc_node_path = '/home/datwaft/.nvm/versions/node/v14.9.0/bin/node'
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                   Variable initialization                                    ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  let g:plugins_folder = '~/.config/nvim/plugged'
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                      Pre-initialization                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                    Shell configuration                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    if &shell =~# 'fish$'
      set shell=zsh
    endif
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
  " │                                      Auxiliar Plugins                                      │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Fix neovim bug
    Plug 'antoinemadec/FixCursorHold.nvim'
    " Asyncronous execution
    Plug 'skywind3000/asyncrun.vim'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                     Aesthetic plugins                                      │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Colorschemes
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    " Status line
    Plug 'itchyny/lightline.vim'
    " Improved search highlight
    Plug 'markonm/traces.vim'
    " Developer icons
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    " Colorized developer icons
    Plug 'lambdalisue/glyph-palette.vim'
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
    " Easy quick-scoping
    Plug 'unblevable/quick-scope'
    " Buffer Tab bar
    Plug 'romgrk/barbar.nvim'
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
    " +------------------------------------------------------------------------------------------+ "
    " |                                         Actions                                          | "
    " +------------------------------------------------------------------------------------------+ "
      " Ability to comment
      Plug 'tpope/vim-commentary'
      " Ability to surround
      Plug 'machakann/vim-sandwich'
      " Easy swap in function
      Plug 'machakann/vim-swap'
      " Exchange objects
      Plug 'tommcdo/vim-exchange'
      " CamelCase and snake_case objects
      Plug 'bkad/camelcasemotion'
    " +------------------------------------------------------------------------------------------+ "
    " |                                         Commands                                         | "
    " +------------------------------------------------------------------------------------------+ "
      " UndoTree
      Plug 'mbbill/undotree'
      " BufferTree
      Plug 'el-iot/buffer-tree'
      " Git management
      Plug 'lambdalisue/gina.vim'
      " Filtering and alignment
      Plug 'godlygeek/tabular'
      " Color converter
      Plug 'amadeus/vim-convert-color-to'
      " Abolish
      Plug 'tpope/vim-abolish'
      " Syntax analizer
      Plug 'vim-scripts/SyntaxAttr.vim'
    " +------------------------------------------------------------------------------------------+ "
    " |                                     File management                                      | "
    " +------------------------------------------------------------------------------------------+ "
      " Quick file search
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
      Plug 'chengzeyi/fzf-preview.vim'
    " +------------------------------------------------------------------------------------------+ "
    " |                                          Others                                          | "
    " +------------------------------------------------------------------------------------------+ "
      " Autocompleter
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      " TreeSitter
      Plug 'nvim-treesitter/nvim-treesitter'
      Plug 'nvim-treesitter/nvim-treesitter-refactor'
      Plug 'nvim-treesitter/nvim-treesitter-textobjects'
      " Tmux integration
      Plug 'christoomey/vim-tmux-navigator'
      " REPL integration
      Plug 'jpalardy/vim-slime'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Language specific plugins                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
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
    " +------------------------------------------------------------------------------------------+ "
    " |                                          LaTeX                                           | "
    " +------------------------------------------------------------------------------------------+ "
      " LaTeX support
      Plug 'lervag/vimtex'
    " +------------------------------------------------------------------------------------------+ "
    " |                                   Cisco configuration                                    | "
    " +------------------------------------------------------------------------------------------+ "
      " Syntax highlight
      Plug 'momota/cisco.vim'
    " +------------------------------------------------------------------------------------------+ "
    " |                                           Fish                                           | "
    " +------------------------------------------------------------------------------------------+ "
      Plug 'dag/vim-fish'
  call plug#end()
  filetype plugin indent on
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                Plugin specific configuration                                 ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                         LightLine                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    function! CocCurrentFunction()
      return get(b:, 'coc_current_function', '')
    endfunction

    let g:lightline = {
    \   'colorscheme': 'material_vim',
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ]
    \     ]
    \   },
    \   'component_function': {
    \     'cocstatus': 'coc#status',
    \     'currentfunction': 'CocCurrentFunction'
    \   },
    \ }
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        Tree Sitter                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " +------------------------------------------------------------------------------------------+ "
    " |                                           Base                                           | "
    " +------------------------------------------------------------------------------------------+ "
      luafile $HOME/.config/nvim/treesitter.lua
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                     FixCursorHold.nvim                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:cursorhold_updatetime = 100
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                     glyph-palette.vim                                      │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    augroup my-glyph-palette
      autocmd! *
      autocmd FileType fern call glyph_palette#apply()
      autocmd FileType nerdtree,startify call glyph_palette#apply()
    augroup END
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          coc.nvim                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " +------------------------------------------------------------------------------------------+ "
    " |                                    Global extensions                                     | "
    " +------------------------------------------------------------------------------------------+ "
      let g:coc_global_extensions = [
      \ 'coc-marketplace',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-xml',
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-tsserver',
      \ 'coc-tslint-plugin',
      \ 'coc-vetur',
      \ 'coc-java',
      \ 'coc-clangd',
      \ 'coc-explorer',
      \ 'coc-vimtex'
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
    " |                                       coc-explorer                                       | "
    " +------------------------------------------------------------------------------------------+ "
      nmap <C-n> :CocCommand explorer<CR>
    " +------------------------------------------------------------------------------------------+ "
    " |                                       coc-snippets                                       | "
    " +------------------------------------------------------------------------------------------+ "
      let g:coc_snippet_next = '<Tab>'
      let g:coc_snippet_prev = '<S-Tab>'
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
      " Show documentation
      nnoremap <silent> K :call <SID>show_documentation()<CR>
      " Symbol renaming
      nmap <leader>rn <Plug>(coc-rename)
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
      " Funtion and class text object
      xmap if <Plug>(coc-funcobj-i)
      omap if <Plug>(coc-funcobj-i)
      xmap af <Plug>(coc-funcobj-a)
      omap af <Plug>(coc-funcobj-a)
      xmap ic <Plug>(coc-classobj-i)
      omap ic <Plug>(coc-classobj-i)
      xmap ac <Plug>(coc-classobj-a)
      omap ac <Plug>(coc-classobj-a)
      " Use <TAB> to select range
      nmap <silent> <C-s> <Plug>(coc-range-select)
      xmap <silent> <C-s> <Plug>(coc-range-select)
    " +------------------------------------------------------------------------------------------+ "
    " |                                   Mappings for CoCList                                   | "
    " +------------------------------------------------------------------------------------------+ "
      " Show all diagnostics.
      nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
      " Manage extensions.
      nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
      " Show commands.
      nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
      " Find symbol of current document.
      nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
      " Search workspace symbols.
      nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
      " Do default action for next item.
      nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item.
      nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list.
      nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        quick-scope                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        exchange.vim                                        │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set timeoutlen=250
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Pandoc                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:pandoc#command#templates_file = split(&runtimepath, ",")[0] . "/.vim-pandoc-templates"
    let g:pandoc#syntax#codeblocks#embeds#use = 1
    let g:pandoc#syntax#codeblocks#embeds#langs = [
      \ "ruby",
      \ "sql",
      \ "python",
      \ "cpp",
      \ "prolog",
      \ "java",
      \ "tasm",
      \ "nasm",
      \ "asm"
      \ ]
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
  " │                                         BufferTree                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Compressed Tree
    let g:buffertree_compress = 1
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                      CamelCaseMotion                                       │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Set default key activation
    let g:camelcasemotion_key = '<leader>'
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           VimTeX                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    let g:tex_flavor = 'latex'
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
    let g:vimtex_quickfix_open_on_warning = 0
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                        barbar.nvim                                         │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Magic buffer-picking mode
    nnoremap <silent> <C-s> :BufferPick<CR>
    " Sort automatically by...
    nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
    nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
    " Move to previous/next
    nnoremap <silent> <A-,> :BufferPrevious<CR>
    nnoremap <silent> <A-.> :BufferNext<CR>
    " Re-order to previous/next
    nnoremap <silent> <A-<> :BufferMovePrevious<CR>
    nnoremap <silent> <A->> :BufferMoveNext<CR>
    " Goto buffer in position...
    nnoremap <silent> <A-1> :BufferGoto 1<CR>
    nnoremap <silent> <A-2> :BufferGoto 2<CR>
    nnoremap <silent> <A-3> :BufferGoto 3<CR>
    nnoremap <silent> <A-4> :BufferGoto 4<CR>
    nnoremap <silent> <A-5> :BufferGoto 5<CR>
    nnoremap <silent> <A-6> :BufferGoto 6<CR>
    nnoremap <silent> <A-7> :BufferGoto 7<CR>
    nnoremap <silent> <A-8> :BufferGoto 8<CR>
    nnoremap <silent> <A-9> :BufferLast<CR>
    " Close buffer
    nnoremap <silent> <A-c> :BufferClose<CR>
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                     Color and Look&Feel                                      ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Colorscheme configuration                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Enable italics
    let g:material_terminal_italics = 1
    " Set theme style
    let g:material_theme_style = 'default'    
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Colorscheme declaration                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Sets colorscheme to dark mode
    set background=dark
    " Colorscheme
    colorscheme material
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
    if has('termguicolors')
      set termguicolors
    endif
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Status                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    set noshowmode
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
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
    " Using <Tab>, <UP>, <S-Tab> and <DOWN> for navigating completion list
    inoremap <expr> <UP>    pumvisible() ? "\<C-p>" : "\<UP>"
    inoremap <expr> <DOWN>  pumvisible() ? "\<C-n>" : "\<DOWN>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " Using <space> to confirm completion
    inoremap <silent><expr> <space> pumvisible() ? coc#_select_confirm() : "\<space>"
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Command-mode completion                                   │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Enable wildmenu
    set wildmenu
    " Set wildmenu opening character to <Tab>
    set wildcharm=<Tab>
    " Wildmenu ignores the case
    set wildignorecase
    " Configure the wildmenu completion
    set wildmode=full
    " Make wildmenu vertical
    set wildoptions+=pum
    " Can use <space> to terminate wildmenu
    cnoremap <expr> <space> wildmenumode() ? "\<C-y>" : "\<space>"
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                  Miscelaneous configuration                                  ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                  Tabulation & Indentation                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Tabulation
    set expandtab
    set smarttab
    set softtabstop=0
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
    set formatoptions+=j
    set formatoptions-=cro
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
    set undodir=~/.config/nvim/undodir.vim
    set undofile
    " Saving marks on exit
    set viminfo='1000,f1
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                    Don't break my flow                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Source: https://vimways.org/2019/making-things-flow/
    function! OpfuncSteady()
      if !empty(&operatorfunc)
        call winrestview(w:opfuncview)
        unlet w:opfuncview
        noautocmd set operatorfunc=
      endif
    endfunction

    augroup OpfuncSteady
      autocmd!
      autocmd OptionSet operatorfunc let w:opfuncview = winsaveview()
      autocmd CursorMoved * call OpfuncSteady()
    augroup END
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Toggle numbers when useful                                 │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
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
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Better scroll performance                                  │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    augroup syntaxSyncMinLines
      autocmd!
      autocmd Syntax * syntax sync minlines=2000
    augroup END
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                 Open file on last position                                 │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                     Open file unfolded                                     │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    au BufRead * normal zR
" ╔══════════════════════════════════════════════════════════════════════════════════════════════╗ "
" ║                                         Text objects                                         ║ "
" ╚══════════════════════════════════════════════════════════════════════════════════════════════╝ "
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                            Line                                            │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Text object inner line
    xnoremap <silent> il :<c-u>normal! g_v^<cr>
    onoremap <silent> il :<c-u>normal! g_v^<cr>
    " Text object around line
    xnoremap <silent> al :<c-u>normal! $v0<cr>
    onoremap <silent> al :<c-u>normal! $v0<cr>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Document                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Text object inner document
    xnoremap <silent> id :<c-u>normal! G$Vgg0<cr>
    onoremap <silent> id :<c-u>normal! GVgg<cr>
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Number                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    " Source: https://vimways.org/2018/transactions-pending/
    " +------------------------------------------------------------------------------------------+ "
    " |                                 Text object inner number                                 | "
    " +------------------------------------------------------------------------------------------+ "
      let s:regNums = [ '0b[01]', '0x\x', '\d' ]
      function! s:inNumber()
        let l:magic = &magic
        set magic
        let l:lineNr = line('.')
        let l:pat = join(s:regNums, '\+\|') . '\+'
        if (!search(l:pat, 'ce', l:lineNr))
          return
        endif
        normal! v
        call search(l:pat, 'cb', l:lineNr)
        let &magic = l:magic
      endfunction

      xnoremap <silent> in :<c-u>call <sid>inNumber()<cr>
      onoremap <silent> in :<c-u>call <sid>inNumber()<cr>
    " +------------------------------------------------------------------------------------------+ "
    " |                                Text object around number                                 | "
    " +------------------------------------------------------------------------------------------+ "
      function! s:aroundNumber()
        let l:magic = &magic
        set magic
        let l:lineNr = line('.')
        let l:pat = join(s:regNums, '\+\|') . '\+'
        if (!search(l:pat, 'ce', l:lineNr))
          return
        endif
        call search('\%'.(virtcol('.')+1).'v\s*', 'ce', l:lineNr)
        normal! v
        call search(l:pat, 'cb', l:lineNr)
        call search('\s*\%'.virtcol('.').'v', 'b', l:lineNr)
        let &magic = l:magic
      endfunction

      xnoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>
      onoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>
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
    inoremap <C-h> <C-o>^
    inoremap <C-l> <C-o>$
    cnoremap <C-h> <home>
    cnoremap <C-l> <end>
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
    augroup asm_ft
      au!
      autocmd BufNewFile,BufRead *.asm set filetype=nasm
    augroup END
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                            JSON                                            │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    autocmd FileType json syntax match Comment +\/\/.\+$+
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                          Markdown                                          │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    autocmd FileType markdown setlocal tabstop=4
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                            SQL                                             │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    autocmd FileType sql setlocal tabstop=2 shiftwidth=2
  " ┌────────────────────────────────────────────────────────────────────────────────────────────┐ "
  " │                                           Prolog                                           │ "
  " └────────────────────────────────────────────────────────────────────────────────────────────┘ "
    au FileType perl set filetype=prolog

