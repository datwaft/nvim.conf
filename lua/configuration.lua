-- =================
-- CONFIGURATION.LUA
-- =================
-- Created by: datwaft [github.com/datwaft]

-- ===================
-- Variable definition
-- ===================
   local configuration_folder = "/home/datwaft/.config/nvim/"
--- ==================
--- Header declaration
--- ==================
if not pcall(require, 'vimp') then
   vim.cmd [[ echom 'Cannot load `vimp`' ]]
   return
end

-- ====================
-- NeoVim Configuration
-- ====================
   vim.g.python3_host_prog = '/usr/bin/python3'
   vim.g.python_host_prog = '/usr/bin/python'
-- ====================
-- Visual configuration
-- ====================
   -- Line numbers
   -- ============
      do local number = true
         vim.o.number = number
         vim.wo.number = number
      end
      do local relativenumber = true
         vim.o.relativenumber = relativenumber
         vim.wo.relativenumber = relativenumber
      end
   -- Syntax highlighting
   -- ===================
      -- Enable plugin syntax
      vim.cmd [[ filetype plugin indent on ]]
      -- Enable syntax highlighting
      vim.cmd [[ syntax enable ]]
   -- Search highlighting
   -- ===================
      vim.o.incsearch = true
      vim.o.hlsearch = false
   -- Split configuration
   -- ===================
      -- Auto resize splits when window is resized
      vim.cmd [[ autocmd VimResized * wincmd = ]]
   -- Conceal configuration
   -- =====================
      vim.wo.concealcursor = ''
   -- Status
   -- ======
      vim.o.showmode = false
   -- Status line
   -- ===========
      -- Define highlight groups
      require'statusline'.define_highlights {
         background = "#2c2e34",
         foreground = "#c5cdd9",
         black = "#3e4249",
         red = "#ec7279",
         green = "#a0c980",
         yellow = "#deb974",
         blue = "#6cb6eb",
         purple = "#d38aea",
         cyan = "#5dbbc1",
         white = "#c5cdd9",
         lightgrey = "#57595e",
         darkgrey = "#404247",
      }
      -- Function definition
      vim.cmd [[
         function! InactiveStatusLine()
            return luaeval("require'statusline'.inactive()")
         endfunction
      ]]
      vim.cmd [[
         function! ActiveStatusLine()
            return luaeval("require'statusline'.active()")
         endfunction
      ]]
      -- Render definition
      vim.cmd'augroup StatusLineRender'
         vim.cmd'autocmd!'
         vim.cmd'autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveStatusLine()'
         vim.cmd'autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveStatusLine()'
      vim.cmd'augroup END'
-- ======================
-- Terminal configuration
-- ======================
   -- Activate mouse
   vim.o.mouse = 'a'
   -- Restore cursor on exit
   vim.cmd [[ au VimLeave * set guicursor=a:ver100-blinkon0 ]]
-- ====================
-- Editor configuration
-- ====================
   -- File configuration
   -- ==================
      -- Don't write backups
      vim.o.backup = false
      vim.o.writebackup = false
      -- No swap file
      do local swapfile = false
         vim.o.swapfile = swapfile
         vim.bo.swapfile = swapfile
      end
   -- Encoding configuration
   -- ======================
      vim.o.encoding = 'utf-8'
   -- Indentation configuration
   -- =========================
      -- Use spaces instead of tabs
      do local expandtab = true
        vim.o.expandtab = expandtab
        vim.bo.expandtab = expandtab
      end
      -- More intelligent tabulation
     vim.o.smarttab = true
      -- Number of spaces that a <Tab> counts for
      do local tabstop = 2
        vim.o.tabstop = tabstop
        vim.bo.tabstop = tabstop
      end
      -- Number of spaces used for autoindent
      do local shiftwidth = vim.o.tabstop
        vim.o.shiftwidth = shiftwidth
        vim.bo.shiftwidth = shiftwidth
      end
      -- Number of spaces a <Tab> counts for
      do local softtabstop = vim.o.tabstop
        vim.o.softtabstop = softtabstop
        vim.bo.softtabstop = softtabstop
      end
      -- Copy indent from current line when starting a new line
      do local autoindent = true
        vim.o.autoindent = autoindent
        vim.bo.autoindent = autoindent
      end
      -- Lua specific configuration
      vim.cmd [[ autocmd FileType lua setlocal tabstop=3 shiftwidth=3 softtabstop=3 expandtab ]]
   -- Wrapping configuration
   -- ======================
      -- Enable soft-wrapping
      do local wrap = true
         vim.o.wrap = wrap
         vim.wo.wrap = wrap
      end
      -- Don't break words at the middle
      do local linebreak = true
         vim.o.linebreak = linebreak
         vim.wo.linebreak = linebreak
      end
      -- Mantain indentation on wrap
      do local breakindent = true
         vim.o.breakindent = breakindent
         vim.wo.breakindent = breakindent
      end
      -- Add characters after wrap
      do local breakindentopt = 'shift:2'
         vim.o.breakindentopt = breakindentopt
         vim.wo.breakindentopt = breakindentopt
      end
      -- Character to show after wrap
      vim.o.showbreak = '↳ '
   -- Format configuration
   -- ====================
      -- Set format options
      do local formatoptions = 'qj'
         vim.o.formatoptions = formatoptions
         vim.bo.formatoptions = formatoptions
      end
   -- Spellcheking configuration
   -- ==========================
      -- Set languages
      do local spelllang = 'en,es'
         vim.o.spelllang = spelllang
         vim.bo.spelllang = spelllang
      end
   -- Undo persistance
   -- ================
      vim.o.undodir = configuration_folder .. "undodir.vim"
      do local undofile = true
         vim.o.undofile = undofile
         vim.bo.undofile = undofile
      end
-- ========================
-- Completion configuration
-- ========================
   -- Insert-mode completion
   -- ======================
      -- The case of the completion is inferred
      vim.o.infercase = true
      -- Function to check if there is a space behind de cursor
      local function check_back_space()
         local col = vim.fn.col'.' - 1
         local line = vim.fn.getline'.'
         local char = string.sub(line, col, col)
         return col == 0 or string.find(char, '%s')
      end
      -- Using <Tab> for triggering completion
      vimp.inoremap({'silent', 'expr'}, '<Tab>', function()
         if vim.fn.pumvisible() == 1 then
            return [[<C-n>]]
         elseif vim.fn['coc#expandableOrJumpable']() then
            return [[<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])<CR>]]
         elseif check_back_space() then
            return [[<Tab>]]
         else
            return vim.fn['coc#refresh']()
         end
      end)
      -- Using <Tab> and <S-Tab> for navigating completion list
      vimp.inoremap({'expr'}, '<S-Tab>', function()
         if vim.fn.pumvisible() == 1 then
            return [[<C-p>]]
         else
            return [[<S-Tab>]]
         end
      end)
      -- Using <space> to confirm completion
      vimp.inoremap({'silent', 'expr'}, '<space>', function()
         if vim.fn.pumvisible() == 1 then
            return vim.fn['coc#_select_confirm']()
         else
            return [[<space>]]
         end
      end)
   -- Command-mode completion
   -- =======================
      -- Enable wildmenu
      vim.o.wildmenu = true
      -- Set wildmenu opening character to <Tab>
      vim.o.wildcharm = 9
      -- Wildmenu ignores case
      vim.o.wildignorecase = true
      -- Use <space> to confirm completion
      vim.cmd [[ cnoremap <expr> <space> wildmenumode() ? "\<C-y>" : "\<space>" ]]
-- =====================
-- Command configuration
-- =====================
   -- Search and replace
   -- ==================
      -- Ignore case in search patterns
      vim.o.ignorecase = true
      -- Smart case in search patterns
      vim.o.smartcase = true
   -- Substitution
   -- ============
      -- Always use global substitution
      vim.o.gdefault = true
-- =============
-- Miscellaneous
-- =============
   -- Toggle pasting
   vim.o.pastetoggle = '<F3>'
   -- Better diffing
   vim.o.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'
   -- Backspace
   vim.o.backspace = 'indent,eol,start'
   -- Lazyredraw
   vim.o.lazyredraw = true
   -- Hidden
   vim.o.hidden = true
   -- Easy jumps to another file
   vim.o.path = vim.o.path .. '**'
   -- Autoread when file changes on disk
   do local autoread = true
      vim.o.autoread = autoread
      vim.bo.autoread = autoread
   end
   vim.cmd [[ autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' && !bufexists("[Command Line]") | checktime | endif ]]
   -- Notification after change on disk
   vim.cmd [[ autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]
   -- Open file on last position
   if vim.fn.has'autocmd' == 1 then
      vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
   end
-- ============
-- Text Objects
-- ============
   -- Line
   -- ====
      -- Text object inner line
      vimp.xnoremap({'silent'}, 'il', ':<c-u>normal! g_v^<cr>')
      vimp.onoremap({'silent'}, 'il', ':<c-u>normal! g_v^<cr>')
      -- Text object around line
      vimp.xnoremap({'silent'}, 'al', ':<c-u>normal! $v0<cr>')
      vimp.onoremap({'silent'}, 'al', ':<c-u>normal! $v0<cr>')
   -- Document
   -- ========
      -- Text object iner document
      vimp.xnoremap({'silent'}, 'id', ':<c-u>normal! G$Vgg0<cr>')
      vimp.onoremap({'silent'}, 'id', ':<c-u>normal! GVgg<cr>')
-- =================
-- Keyboard bindings
-- =================
   -- Folding
   -- =======
      -- Fold or unfold all
      vimp.nnoremap({'expr'}, '<f2>', function()
         if vim.wo.foldlevel == 1 then
            return 'zM'
         else
            return 'zR'
         end
      end)
      -- Fold or unfold local
      vimp.nnoremap({'silent'}, '<leader><space>', 'za')
   -- Movement
   -- ========
      -- Move vertically on wrapped lines
      do local function vert_move(original, char, insert)
            return function()
               if vim.v.count ~= 0 then
                  return (vim.v.count > 5 and "m'" or '') .. original
               else
                  return (insert and '<C-o>' or '') .. 'g' .. char
               end
            end
         end
         vimp.nnoremap({'expr'}, 'j', vert_move('j', 'j', false))
         vimp.nnoremap({'expr'}, 'k', vert_move('k', 'k', false))
         vimp.nnoremap({'expr'}, '<up>', vert_move('<up>', 'k', false))
         vimp.nnoremap({'expr'}, '<down>', vert_move('<down>', 'j', false))
         vimp.inoremap({'expr'}, '<up>', vert_move('<up>', 'k', true))
         vimp.inoremap({'expr'}, '<down>', vert_move('<down>', 'j', true))
      end
      -- Move to the beginning or the end with H or L
      vimp.nnoremap('H', '^')
      vimp.nnoremap('L', '$')
      vimp.inoremap('<C-h>', '<C-o>^')
      vimp.inoremap('<C-l>', '<C-o>$')
      vimp.cnoremap('<C-h>', '<home>')
      vimp.cnoremap('<C-l>', '<end>')
   -- Miscellaneous
   -- =============
      -- Use Y to copy from the cursor to the end
      vimp.nnoremap('Y', 'y$')
      -- Fast execute macro
      vimp.xnoremap('Q', ':normal @@<CR>')
      vimp.nnoremap('Q', ':normal @@<CR>')
      -- Move lines up and down
      vimp.nnoremap('<C-up>', ':m-2<CR>')
      vimp.nnoremap('<C-down>', ':m+<CR>')
-- ===============================
-- Language specific configuration
-- ===============================
   -- Prolog
   -- ======
      vim.cmd [[ autocmd BufNewFile,BufRead *.pl set filetype=prolog ]]
