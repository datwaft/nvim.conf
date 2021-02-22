-- =========================
-- NEOVIM CONFIGURATION FILE
-- =========================
-- Created by datwaft <github.com/datwaft>

-- ==================
-- Imports definition
-- ==================
  local options = require'core.options'
  local io = require'utils.io'
  local prerequire = require'utils.prerequire'
  local autocmd = require'core.autocmd'
  if not prerequire'vimp' then
    io.warning"Couldn't load `vimp` package"
    return
  else
    vimp.unmap_all()
  end
-- ===================
-- Variable definition
-- ===================
  local configuration_folder = vim.fn.expand'~'..'/.config/nvim'
-- ====================
-- Editor configuration
-- ====================
  -------------------------------
  -- External tools configuration
  -------------------------------
    -- Set python path
    vim.g.python3_host_prog = '/usr/local/share/anaconda/bin/python3'
  ---------------------
  -- File configuration
  ---------------------
    -- Do not write backups
    options.backup = false
    options.writebackup = false
    -- Do not create swap files
    options.swapfile = false
  -------------------------
  -- Encoding configuration
  -------------------------
    options.encoding = 'utf-8'
  ----------------------------
  -- Indentation configuration
  ----------------------------
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
  -------------------------
  -- Wrapping configuration
  -------------------------
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
  -----------------------
  -- Format configuration
  -----------------------
    options.formatoptions = 'qj'
  ------------------------------
  -- Spellchecking configuration
  ------------------------------
    options.spelllang = 'en,es'
  -------------------
  -- Undo persistance
  -------------------
    options.undodir = configuration_folder..'/undodir.nvim'
    options.undofile = true
-- ======================
-- Terminal configuration
-- ======================
  -- Enable mouse support
  options.mouse = 'a'
  -- Restore cursor on exit
  autocmd {
    events = { 'VimLeave' },
    pattern = '*',
    command = 'set guicursor=a:ver100-blinkon0'
  }
-- ====================
-- Visual configuration
-- ====================
  ---------------------
  -- True color support
  ---------------------
    options.termguicolors = true
  ---------------
  -- Line numbers
  ---------------
    options.number = true
    options.relativenumber = true
  ----------------------
  -- Syntax highlighting
  ----------------------
    vim.cmd [[filetype plugin indent on]]
    vim.cmd [[syntax enable]]
  ----------------------
  -- Search highlighting
  ----------------------
    options.incsearch = true
    options.hlsearch = false
  ----------------------
  -- Split configuration
  ----------------------
    -- Auto resize splits when window is resized
    autocmd {
      events = { 'VimResized' },
      pattern = '*',
      command = 'wincmd ='
    }
  ------------------------
  -- Conceal configuration
  ------------------------
    options.concealcursor = ''
  -----------------------
  -- Status configuration
  -----------------------
    options.showmode = false
  ------------------------------
  -- Column marker configuration
  ------------------------------
    options.colorcolumn = '81'
  ---------------------------
  -- Characters configuration
  ---------------------------
    -- Show whitespace characters
    options.list = true
    -- Show trailing whitespace as dots
    options.listchars = 'trail:·,tab:→ ,nbsp:·'
-- ========================
-- Completion configuration
-- ========================
  -------------------------
  -- Insert-mode completion
  -------------------------
    options.infercase = true
  --------------------------
  -- Command-mode completion
  --------------------------
    -- Enable wildmenu
    options.wildmenu = true
    -- Set wildmenu opening character to <Tab>
    options.wildcharm = 9
    -- Wildmenu ignores case
    options.wildignorecase = true
    -- Use <space> to confirm completion
    vimp.cnoremap(
      {'expr'},
      '<space>',
      [[wildmenumode() ? "\<C-y>" : "\<space>"]]
    )
-- =====================
-- Command configuration
-- =====================
  ---------------------
  -- Search and replace
  ---------------------
    options.ignorecase = true
    options.smartcase = true
  ---------------
  -- Substitution
  ---------------
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
  -- Autoread when file chages on disk
  options.autoread = true
  autocmd {
    events = { 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' },
    pattern = '*',
    command = {
      name = 'autoread_on_file_change',
      command = function()
        if vim.fn.mode() ~= 'c'
            and vim.fn.bufexists("[Command Line]") == 0 then
          vim.cmd [[checktime]]
        end
      end
    }
  }
  autocmd {
    events = { 'FileChangedShellPost' },
    pattern = '*',
    command = {
      name = 'warn_on_file_change',
      command = function()
        io.raw_warn'File changed on disk. Buffer reloaded'
      end
    }
  }
  -- Open file on last position
  autocmd {
    events = { 'BufReadPost' },
    pattern = '*',
    command = {
      name = 'open_file_on_last_position',
      command = function()
        if vim.fn.line([['"]]) > 1
            and vim.fn.line([['"]]) <= vim.fn.line('$') then
          vim.cmd [[normal! g'"]]
        end
      end
    }
  }
-- ============
-- Text objects
-- ============
  --------------
  -- Line object
  --------------
    -- Inner line
    vimp.xnoremap({'silent'}, 'il', ':<C-u>normal! g_v^<cr>')
    vimp.onoremap({'silent'}, 'il', ':<C-u>normal! g_v^<cr>')
    -- Around line
    vimp.xnoremap({'silent'}, 'al', ':<C-u>normal! $v0<cr>')
    vimp.onoremap({'silent'}, 'al', ':<C-u>normal! $v0<cr>')
  -----------
  -- Document
  -----------
    -- Inner document
    vimp.xnoremap({'silent'}, 'id', ':<C-u>normal! G$Vgg0<cr>')
    vimp.onoremap({'silent'}, 'id', ':<C-u>normal! GVgg<cr>')
-- =================
-- Keyboard bindings
-- =================
  ----------
  -- Folding
  ----------
    -- Fold or unfold all
    vimp.nnoremap({'silent'}, '<F2>', function()
      if vim.wo.foldlevel == 1 then
        return 'zM'
      else
        return 'zR'
      end
    end)
    -- Fold or unfold local
    vimp.nnoremap({'silent'}, '<leader><space>', 'za')
  -----------
  -- Movement
  -----------
    -- Move vertically on wrapped lines
    do
      local function vertical_movement(original, char, insert)
        local result
        if vim.v.count ~= 0 then
          result = (vim.v.count > 5 and "m'" or '')..original
        else
          result = (insert and '<C-o>' or '')..'g'..char
        end
        return result
      end
      vimp.nnoremap({'silent', 'expr'}, 'j', function()
        return vertical_movement('j', 'j', false)
      end)
      vimp.nnoremap({'silent', 'expr'}, 'k', function()
        return vertical_movement('k', 'k', false)
      end)
      vimp.nnoremap({'silent', 'expr'}, '<up>', function()
        return vertical_movement('<up>', 'k', false)
      end)
      vimp.nnoremap({'silent', 'expr'}, '<down>', function()
        return vertical_movement('<down>', 'j', false)
      end)
      vimp.inoremap({'silent', 'expr'}, '<up>', function()
        return vertical_movement('<up>', 'k', true)
      end)
      vimp.inoremap({'silent', 'expr'}, '<down>', function()
        return vertical_movement('<down>', 'j', true)
      end)
    end
    -- Move to the beginning or the end with H or L
    vimp.nnoremap({'silent'}, 'H', '^')
    vimp.nnoremap({'silent'}, 'L', '$')
    vimp.inoremap({'silent'}, '<C-h>', '<C-o>^')
    vimp.inoremap({'silent'}, '<C-l>', '<C-o>$')
    vimp.cnoremap('<C-h>', '<home>')
    vimp.cnoremap('<C-l>', '<end>')
    -- Remove character
    vimp.inoremap({'silent'}, '<C-s>', '<BS>')
  ----------------
  -- Miscellaneous
  ----------------
    -- Use Y to copy from the cursor to the end
    vimp.nnoremap({ 'silent' }, 'Y', 'y$')
    -- Fast execute macro
    vimp.xnoremap({ 'silent' }, 'Q', ':normal @@<CR>')
    vimp.nnoremap({ 'silent' }, 'Q', ':normal @@<CR>')
    -- Move lines up and down
    vimp.nnoremap({ 'silent' }, '<C-k>', ':m-2<CR>')
    vimp.nnoremap({ 'silent' }, '<C-up>', ':m-2<CR>')
    vimp.nnoremap({ 'silent' }, '<C-j>', ':m+<CR>')
    vimp.nnoremap({ 'silent' }, '<C-down>', ':m+<CR>')
-- ===============================
-- Language specific configuration
-- ===============================
  ---------
  -- Prolog
  ---------
    autocmd {
      events = { 'BufNewFile', 'BufRead' },
      pattern = '*.pl',
      command = 'set filetype=prolog'
    }
