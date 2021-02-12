-- =========================
-- NEOVIM CONFIGURATION FILE
-- =========================
-- Created by datwaft <github.com/datwaft>

-- ==================
-- Imports definition
-- ==================
   local options = require'core.options'
   local io = require'utils.io'
   local t = io.replace_termcodes
-- ===================
-- Variable definition
-- ===================
   local configuration_folder = vim.fn.expand'~'..'/.config/nvim'
-- ====================
-- Editor configuration
-- ====================
   -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   -- External tools configuration
   -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      -- Set python path
      vim.g.python3_host_prog = '/usr/local/share/anaconda/bin/python3'
   -- ~~~~~~~~~~~~~~~~~~
   -- File configuration
   -- ~~~~~~~~~~~~~~~~~~
      -- Do not write backups
      options.backup = false
      options.writebackup = false
      -- Do not create swap files
      options.swapfile = false
   -- ~~~~~~~~~~~~~~~~~~~~~~
   -- Encoding configuration
   -- ~~~~~~~~~~~~~~~~~~~~~~
      options.encoding = 'utf-8'
   -- ~~~~~~~~~~~~~~~~~~~~~~~~~
   -- Indentation configuration
   -- ~~~~~~~~~~~~~~~~~~~~~~~~~
      -- Use spaces instead of tabs
      options.expandtab = true
      -- More intelligent tabulation
      options.smarttab = true
      -- Number of spaces that a <Tab> counts for
      options.tabstop = 2
      -- Number of spaces used for autoindent
      options.shiftwidth = options.tabstop
      -- Number of spaces that a <Tab> counts for
      options.softtabstop = options.tabstop
      -- Copy indent from current line when starting a new line
      options.autoindent = true
      -- Lua specific indentation
      vim.cmd [[autocmd FileType lua setlocal tabstop=3 shiftwidth=3 softtabstop=3 expandtab]]
   -- ~~~~~~~~~~~~~~~~~~~~~~
   -- Wrapping configuration
   -- ~~~~~~~~~~~~~~~~~~~~~~
      -- Enable soft-wrapping
      options.wrap = true
      -- Do not break words at the middle
      options.linebreak = true
      -- Mantain indentation on wrap
      options.breakindent = true
      -- Add characters after wrap
      options.breakindentopt = 'shift:2'
      -- Character to show after wrap
      options.showbreak = '↳ '
   -- ~~~~~~~~~~~~~~~~~~~~
   -- Format configuration
   -- ~~~~~~~~~~~~~~~~~~~~
      options.formatoptions = 'qj'
   -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   -- Spellchecking configuration
   -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      options.spelllang = 'en,es'
   -- ~~~~~~~~~~~~~~~~
   -- Undo persistance
   -- ~~~~~~~~~~~~~~~~
      options.undodir = configuration_folder..'/undodir.nvim'
      options.undofile = true
-- ======================
-- Terminal configuration
-- ======================
   -- Enable mouse support
   options.mouse = 'a'
   -- Restore cursor on exit
   vim.cmd [[autocmd VimLeave * set guicursor=a:ver100-blinkon0]]
-- ====================
-- Visual configuration
-- ====================
   -- ~~~~~~~~~~~~
   -- Line numbers
   -- ~~~~~~~~~~~~
      options.number = true
      options.relativenumber = true
   -- ~~~~~~~~~~~~~~~~~~~
   -- Syntax highlighting
   -- ~~~~~~~~~~~~~~~~~~~
      vim.cmd [[filetype plugin indent on]]
      vim.cmd [[syntax enable]]
   -- ~~~~~~~~~~~~~~~~~~~
   -- Search highlighting
   -- ~~~~~~~~~~~~~~~~~~~
      options.incsearch = true
      options.hlsearch = false
   -- ~~~~~~~~~~~~~~~~~~~
   -- Split configuration
   -- ~~~~~~~~~~~~~~~~~~~
      -- Auto resize splits when window is resized
      vim.cmd [[autocmd VimResized * wincmd =]]
   -- ~~~~~~~~~~~~~~~~~~~~~
   -- Conceal configuration
   -- ~~~~~~~~~~~~~~~~~~~~~
      options.concealcursor = ''
   -- ~~~~~~~~~~~~~~~~~~~~
   -- Status configuration
   -- ~~~~~~~~~~~~~~~~~~~~
      options.showmode = false
-- ========================
-- Completion configuration
-- ========================
   -- ~~~~~~~~~~~~~~~~~~~~~~
   -- Insert-mode completion
   -- ~~~~~~~~~~~~~~~~~~~~~~
      options.infercase = true
   -- ~~~~~~~~~~~~~~~~~~~~~~~
   -- Command-mode completion
   -- ~~~~~~~~~~~~~~~~~~~~~~~
      -- Enable wildmenu
      options.wildmenu = true
      -- Set wildmenu opening character to <Tab>
      options.wildcharm = 9
      -- Wildmenu ignores case
      options.wildignorecase = true
      -- Use <space> to confirm completion
      _G.smart_command_space = function()
         if vim.fn.wildmenumode() == 1 then
            return t'<C-n>'
         else
            return t'<space>'
         end
      end
      vim.api.nvim_set_keymap('c', '<space>', 'v:lua.smart_command_space()', { noremap = true, expr = true })
-- =====================
-- Command configuration
-- =====================
   -- ~~~~~~~~~~~~~~~~~~
   -- Search and replace
   -- ~~~~~~~~~~~~~~~~~~
      options.ignorecase = true
      options.smartcase = true
   -- ~~~~~~~~~~~~
   -- Substitution
   -- ~~~~~~~~~~~~
      options.gdefault = true
-- ===========================
-- Miscellaneous configuration
-- ===========================
   -- Toggle paste mode
   options.pastetoggle = '<F3>'
   -- Better diffing
   options.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'
   -- Backspace
   options.backspace = 'indent,eol,start'
   -- Lazyredraw
   options.lazyredraw = true
   -- Hidden
   options.hidden = true
   -- Easy jumps to another file
   options.path = options.path..'**'
   -- Autoread when file chages on disk
   options.autoread = true
   _G.autoread_on_file_changed = function()
      if vim.fn.mode() ~= 'c' and vim.fn.bufexists("[Command Line]") == 0 then
         vim.cmd [[checktime]]
      end
   end
   vim.cmd [[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * :call v:lua.autoread_on_file_changed()]]
   _G.warn_on_file_changed = function()
      io.warn'File changed on disk. Buffer reloaded'
   end
   vim.cmd [[autocmd FileChangedShellPost * :call v:lua.warn_on_file_changed()]]
   -- Open file on last position
   _G.open_file_on_last_position = function()
      if vim.fn.line([['"]]) > 1 and vim.fn.line([['"]]) <= vim.fn.line('$') then
         vim.cmd [[normal! g'"]]
      end
   end
   vim.cmd [[autocmd BufReadPost * :call v:lua.open_file_on_last_position()]]
-- ============
-- Text objects
-- ============
   -- ~~~~~~~~~~~
   -- Line object
   -- ~~~~~~~~~~~
      -- Inner line
      vim.api.nvim_set_keymap('x', 'il', ':<C-u>normal! g_v^<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('o', 'il', ':<C-u>normal! g_v^<cr>', { noremap = true, silent = true })
      -- Around line
      vim.api.nvim_set_keymap('x', 'al', ':<C-u>normal! $v0<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('o', 'al', ':<C-u>normal! $v0<cr>', { noremap = true, silent = true })
   -- ~~~~~~~~
   -- Document
   -- ~~~~~~~~
      -- Inner document
      vim.api.nvim_set_keymap('x', 'id', ':<C-u>normal! G$Vgg0<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('o', 'id', ':<C-u>normal! GVgg<cr>', { noremap = true, silent = true })
-- =================
-- Keyboard bindings
-- =================
   -- ~~~~~~~
   -- Folding
   -- ~~~~~~~
      -- Fold or unfold all
      _G.fold_or_unfold_all = function()
         if vim.wo.foldlevel == 1 then
            return 'zM'
         else
            return 'zR'
         end
      end
      vim.api.nvim_set_keymap('n', '<F2>', 'v:lua.fold_or_unfold_all()', { noremap = true, silent = true, expr = true })
      -- Fold or unfold local
      vim.api.nvim_set_keymap('n', '<leader><space>', 'za', { noremap = true, silent = true })
   -- ~~~~~~~~
   -- Movement
   -- ~~~~~~~~
      -- Move vertically on wrapped lines
      _G.vertical_movement = function (original, char, insert)
         if vim.v.count ~= 0 then
            return (vim.v.count > 5 and "m'" or '')..original
         else
            return (insert and '<C-o>' or '')..'g'..char
         end
      end
      vim.api.nvim_set_keymap('n', 'j', [[v:lua.vert_move('j', 'j', false)]], { noremap = true, expr = true })
      vim.api.nvim_set_keymap('n', 'k', [[v:lua.vert_move('k', 'k', false)]], { noremap = true, expr = true })
      vim.api.nvim_set_keymap('n', '<up>', [[v:lua.vert_move('<up>', 'k', false)]], { noremap = true, expr = true })
      vim.api.nvim_set_keymap('n', '<down>', [[v:lua.vert_move('<down>', 'j', false)]], { noremap = true, expr = true })
      vim.api.nvim_set_keymap('i', '<up>', [[v:lua.vert_move('<up>', 'k', true)]], { noremap = true, expr = true })
      vim.api.nvim_set_keymap('i', '<down>', [[v:lua.vert_move('<down>', 'j', true)]], { noremap = true, expr = true })
      -- Move to the beginning or the end with H or L
      vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', '<C-h>', '<C-o>^', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('i', '<C-l>', '<C-o>$', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('c', '<C-h>', '<home>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('c', '<C-l>', '<end>', { noremap = true, silent = true })
      -- Remove character
      vim.api.nvim_set_keymap('i', '<C-s>', '<BS>', { silent = true })
   -- ~~~~~~~~~~~~~
   -- Miscellaneous
   -- ~~~~~~~~~~~~~
      -- Use Y to copy from the cursor to the end
      vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })
      -- Fast execute macro
      vim.api.nvim_set_keymap('x', 'Q', ':normal @@<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'Q', ':normal @@<CR>', { noremap = true, silent = true })
      -- Move lines up and down
      vim.api.nvim_set_keymap('n', '<C-up>', ':m-2<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-down>', ':m+<CR>', { noremap = true, silent = true })
-- ===============================
-- Language specific configuration
-- ===============================
   -- ~~~~~~
   -- Prolog
   -- ~~~~~~
      vim.cmd [[autocmd BufNewFile,BufRead *.pl set filetype=prolog]]
