-----------
-- Settings
-----------
-- Enable bytecode cache
vim.loader.enable()
-- Set <leader> to '\'
vim.g.mapleader = [[\]]
-- Set <localleader> to <SPACE>
vim.g.maplocalleader = [[ ]]
-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
-- Wrapping
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = { "shift:2" }
vim.opt.showbreak = "↳ "
-- Folding
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
-- Undo persistence
vim.opt.undofile = true
-- Enable local configuration
vim.opt.exrc = true
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Scrolling
vim.opt.splitkeep = "screen"
vim.opt.smoothscroll = true
-- Command-line
vim.opt.showmode = false
-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
  trail = "·",
  tab = "→ ",
  nbsp = "·",
}
-- Spell-checking
vim.opt.spell = true
vim.opt.spelllang = { "programming", "en", "es" }
vim.opt.spellfile = {
  vim.fn.stdpath("config") .. "/spell/programming.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/es.utf-8.add",
}
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""
-- Sign column
vim.opt.signcolumn = "yes:1"
-- Insert-mode completion
vim.opt.shortmess:append("c")
-- Grep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
-- Mouse
vim.opt.mousemodel = "extend"
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleDrag>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleRelease>", "<Nop>")

------------
-- Providers
------------
vim.g.python3_host_prog = "~/.asdf/shims/python3"
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

---------------
-- Autocommands
---------------
-- Open files on the last position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    vim.cmd([[silent! normal! g`"zv]])
  end,
})
-- Resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd.wincmd("=")
  end,
})
-- Set some options on the terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    -- Start on insert mode
    vim.cmd.startinsert()
    -- Disable line numbers
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    -- Disable spell checking
    vim.opt_local.spell = false
    -- Disable sign column
    vim.opt_local.signcolumn = "no"
    -- Disable colorcolumn
    vim.opt_local.colorcolumn = {}
  end,
})
-- Always disable 'spell' on some filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "checkhealth",
    "gitignore",
    "help",
    "qf",
    "man",
  },
  callback = function()
    vim.opt_local.spell = false
  end,
})
-- Always enable 'spell' on some filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "markdown",
    "tex",
    "quarto",
  },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-----------
-- Keybinds
-----------
-- Disable highlights with <ESC>
vim.keymap.set("n", "<ESC>", "<ESC><CMD>nohlsearch<CR>")
-- Make `/` and `?` search inside selection
vim.keymap.set("x", "/", [[<ESC>/\%V]])
vim.keymap.set("x", "?", [[<ESC>?\%V]])
-- Make mappings similar to TMUX mappings for Vim tabs
vim.keymap.set("n", "<C-t>n", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-t>s", "<CMD>tabs<CR>")
vim.keymap.set("n", "<C-t>[", "<CMD>tabnext<CR>")
vim.keymap.set("n", "<C-t>]", "<CMD>tabprevious<CR>")
vim.keymap.set("n", "<C-t>w", "<CMD>tabclose<CR>")
vim.keymap.set("n", "<C-t>q", "<CMD>tabclose<CR>")
-- Close wildmenu using <SPACE>
vim.keymap.set("c", "<SPACE>", function()
  return vim.fn.wildmenumode() == 1 and "<C-y>" or "<SPACE>"
end, { expr = true })

---------------
-- Text objects
---------------
-- Line text objects
vim.keymap.set({ "x", "o" }, "il", ":<C-u>normal! g_v^<CR>", { silent = true })
vim.keymap.set({ "x", "o" }, "al", ":<C-u>normal! $v0<CR>", { silent = true })
-- Document text objects
vim.keymap.set({ "x", "o" }, "id", ":<C-u>normal! G$vgg0<CR>", { silent = true })

--------------
-- Diagnostics
--------------
-- Configure diagnostics
vim.diagnostic.config({
  underline = { severity = { min = vim.diagnostic.severity.INFO } },
  signs = { severity = { min = vim.diagnostic.severity.HINT } },
  virtual_text = false,
  float = { show_header = false, source = true },
  update_in_insert = false,
  severity_sort = true,
})
-- Set diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignOk", { text = " ", texthl = "DiagnosticSignOk" })
-- Keybind for showing line diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
-- Keybind for going to diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- Keybind for listing diagnostics
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist)
-- Keybind for toggling diagnostics
vim.keymap.set("n", "<leader>td", function()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end)

---------------------------------
-- LSP keybinds and configuration
---------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- Show documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    -- Go to declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
    -- Go to implementation
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
    -- Go to references
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    -- Rename symbol under cursor
    vim.keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, buffer = bufnr })
    -- Apply code actions
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
    -- Toggle inlay hints
    if client.supports_method("textDocument/inlayHint") then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
      end, { buffer = bufnr })
    end

    -- Enable inlay hints by default
    vim.lsp.inlay_hint.enable(bufnr, true)

    -- Disable semantic highlighting for some LSPs
    for _, name in ipairs({ "dockerls" }) do
      if client.name == name then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end
    -- Disable hover for some LSPs
    for _, name in ipairs({ "ruff_lsp" }) do
      if client.name == name then
        client.server_capabilities.hoverProvider = nil
      end
    end
    -- Disable formatting for some LSPs
    for _, name in ipairs({ "jsonls" }) do
      if client.name == name then
        client.server_capabilities.documentFormattingProvider = nil
        client.server_capabilities.documentRangeFormattingProvider = nil
      end
    end
  end,
})

-------------------------
-- Filetype configuration
-------------------------
vim.filetype.add({ filename = { ["go.mod"] = "gomod" } })
vim.filetype.add({ pattern = { [".*/queries/.*%.scm"] = "query" } })
vim.filetype.add({ pattern = { [".*/%.husky/.*"] = "sh" } })

--------------------------
-- lazy.nvim configuration
--------------------------
local packages_path = vim.fn.stdpath("data") .. "/lazy"

-- Helper function to install packages before lazy.nvim is loaded
---@param name string
---@param alias string?
local function install_package(name, alias)
  ---@type unknown, unknown, string, string
  local _, _, owner, repo = name:find([[(.+)/(.+)]])
  local path = ("%s/%s"):format(packages_path, alias or repo)

  if not vim.uv.fs_stat(path) then
    vim.notify(("Installing %s/%s..."):format(owner, repo), vim.log.levels.INFO)

    vim
      .system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        ("https://github.com/%s/%s.git"):format(owner, repo),
        path,
      })
      :wait()
  end

  vim.opt.runtimepath:prepend(path)
end

install_package("folke/lazy.nvim")
install_package("catppuccin/nvim", "catppuccin")

vim.cmd.colorscheme("catppuccin-mocha")

require("lazy").setup("packages", {
  change_detection = { notify = false },
  dev = { path = "~/Developer/Git/" },
  ui = { backdrop = 100 },
})
