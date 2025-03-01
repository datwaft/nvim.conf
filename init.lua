----------
-- Helpers
----------

-- Helper to define a sign with its `name` as `texthl`
---@param name string
---@param text string
---@return -1|0
function _G.define_sign(name, text) return vim.fn.sign_define(name, { text = text, texthl = name }) end

-----------
-- Settings
-----------
-- Enable bytecode cache
vim.loader.enable()
-- Set <leader> to '\'
vim.g.mapleader = [[\]]
-- Set <localleader> to <SPACE>
vim.g.maplocalleader = [[ ]]
-- Swap
vim.opt.swapfile = false
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
vim.opt.scrolloff = 7
-- Command-line
vim.opt.showmode = false
-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
  trail = "·",
  tab = "→ ",
  nbsp = "·",
}
-- Diffs
vim.opt.fillchars:append({ diff = "/" })
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
vim.opt.mousescroll = "ver:2,hor:0"
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleDrag>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleRelease>", "<Nop>")
-- Link identification
vim.opt.isfname:append("*")

---------------
-- Autocommands
---------------
-- Open files on the last position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("open-file-last-position", { clear = true }),
  command = [[silent! normal! g`"zv]],
})
-- Resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize-splits-on-resize", { clear = true }),
  command = "wincmd =",
})
-- Set some options on the terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("terminal-options", { clear = true }),
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
  group = vim.api.nvim_create_augroup("disable-spell", { clear = true }),
  pattern = {
    "checkhealth",
    "gitignore",
    "help",
    "qf",
    "man",
    "editorconfig",
    "query",
    "molten_output",
  },
  callback = function() vim.opt_local.spell = false end,
})
-- Always enable 'spell' on some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("enable-spell", { clear = true }),
  pattern = {
    "markdown",
    "tex",
    "quarto",
  },
  callback = function() vim.opt_local.spell = true end,
})
-- Always enable 'conceallevel' on some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("enable-conceal", { clear = true }),
  pattern = { "html" },
  callback = function() vim.opt_local.conceallevel = 2 end,
})

-----------
-- Keybinds
-----------
-- Go to folder with -
vim.keymap.set("n", "-", "<CMD>e %:h<CR>")
-- Disable highlights with <ESC>
vim.keymap.set("n", "<ESC>", "<ESC><CMD>nohlsearch<CR>")
-- Make mappings similar to TMUX mappings for Vim tabs
vim.keymap.set("n", "<C-t>n", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-t>s", "<CMD>tabs<CR>")
vim.keymap.set("n", "<C-t>[", "<CMD>tabnext<CR>")
vim.keymap.set("n", "<C-t>]", "<CMD>tabprevious<CR>")
vim.keymap.set("n", "<C-t>w", "<CMD>tabclose<CR>")
vim.keymap.set("n", "<C-t>q", "<CMD>tabclose<CR>")
-- Close wildmenu using <SPACE>
vim.keymap.set(
  "c",
  "<SPACE>",
  function() return vim.fn.wildmenumode() == 1 and "<C-y>" or "<SPACE>" end,
  { expr = true }
)
-- Make `j` work with wrapped lines
vim.keymap.set({ "n", "v" }, "j", function()
  if vim.v.count == 0 then
    return "gj"
  else
    return "j"
  end
end, { expr = true })
-- Make `k` work with wrapped lines
vim.keymap.set({ "n", "v" }, "k", function()
  if vim.v.count == 0 then
    return "gk"
  else
    return "k"
  end
end, { expr = true })
-- Make `<Up>` work with wrapped lines
vim.keymap.set({ "n", "v" }, "<Up>", function()
  if vim.v.count == 0 then
    return "gk"
  else
    return "<Up>"
  end
end, { expr = true })
-- Make `<Down>` work with wrapped lines
vim.keymap.set({ "n", "v" }, "<Down>", function()
  if vim.v.count == 0 then
    return "gj"
  else
    return "<Down>"
  end
end, { expr = true })
-- Do not jump with <S-Up> and <S-Down>
vim.keymap.set({ "i", "n", "v" }, "<S-Up>", "<Up>", { remap = true })
vim.keymap.set({ "i", "n", "v" }, "<S-Down>", "<Down>", { remap = true })
-- Use <M-Left> and <M-Right> for moving between words
vim.keymap.set({ "c", "i", "n", "v" }, "<M-Left>", "<S-Left>")
vim.keymap.set({ "c", "i", "n", "v" }, "<M-Right>", "<S-Right>")
-- Search on selected text
vim.keymap.set("x", "g/", "<Esc>/\\%V")

---------------
-- Text objects
---------------
-- Line text objects
vim.keymap.set({ "x", "o" }, "iL", ":<C-u>normal! g_v^<CR>", { silent = true })
vim.keymap.set({ "x", "o" }, "aL", ":<C-u>normal! $v0<CR>", { silent = true })
-- Document text objects
vim.keymap.set({ "x", "o" }, "id", ":<C-u>normal! G$vgg0<CR>", { silent = true })

--------
-- Icons
--------
_G.icons = {
  diagnostic = {
    error = "󱎘",
    warn = "󱈸",
    info = "󰙎",
    hint = "󰌵",
    ok = "󰸞",
  },
  git = {
    added = "+",
    modified = "~",
    removed = "-",
  },
  debug = {
    breakpoint = "󰍡",
    condition = "󰍩",
    log = "󰍣",
    stopped = "󰍥",
    rejected = "󱙎",
  },
}
_G.border = "rounded"

--------------
-- Diagnostics
--------------
-- Configure diagnostics
vim.diagnostic.config({
  underline = { severity = { min = vim.diagnostic.severity.HINT } },
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostic.warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostic.info,
      [vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
    },
  },
  virtual_lines = false,
  float = {
    show_header = false,
    source = true,
    border = border,
  },
  update_in_insert = false,
  severity_sort = true,
})
-- Keybind for listing diagnostics
vim.keymap.set("n", "<C-w>D", vim.diagnostic.setqflist)
-- Keybind for toggling diagnostics
vim.g.enable_diagnostic_virtual_lines = false
vim.keymap.set("n", "<leader>td", function()
  vim.g.enable_diagnostic_virtual_lines = not vim.g.enable_diagnostic_virtual_lines
  if vim.g.enable_diagnostic_virtual_lines then
    vim.diagnostic.config({ virtual_lines = { severity = { min = vim.diagnostic.severity.INFO } } })
  else
    vim.diagnostic.config({ virtual_lines = false })
  end
end)

---------------------------------
-- LSP keybinds and configuration
---------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach-config", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- Show hover documentation
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = border }) end, { buffer = bufnr })
    -- Show signature help
    vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help({ border = border }) end, { buffer = bufnr })
    -- Code actions
    vim.keymap.set({ "n", "x" }, "gra", "<cmd>lua require('fastaction').code_action()<cr>", { buffer = bufnr })
    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gD", "<cmd>Glance definitions<cr>", { buffer = bufnr })
    -- Go to type definition
    vim.keymap.set("n", "gt", function()
      vim.lsp.buf.type_definition({
        on_list = function(t) vim.lsp.util.show_document(t.items[1].user_data, "utf-8", { focus = true }) end,
      })
    end, { buffer = bufnr })
    vim.keymap.set("n", "gT", "<cmd>Glance type_definitions<cr>", { buffer = bufnr })
    -- List all implementations
    vim.keymap.set("n", "<C-w>i", "<cmd>Glance implementations<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<C-w>I", vim.lsp.buf.implementation, { buffer = bufnr })
    -- List all references
    vim.keymap.set("n", "<C-w>r", "<cmd>Glance references<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<C-w>R", vim.lsp.buf.references, { buffer = bufnr })
    -- List all symbols
    vim.keymap.set("n", "<C-w>S", "<cmd>Namu symbols<cr>", { buffer = bufnr })
    -- Rename symbol under cursor
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = bufnr })
    -- Toggle inlay hints
    if client:supports_method("textDocument/inlayHint") then
      vim.keymap.set(
        "n",
        "<leader>th",
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr }) end,
        { buffer = bufnr }
      )
    end

    -- Enable inlay hints by default
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    -- Use LSP-provided folding if possible
    if client:supports_method("textDocument/foldingRange") then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- Disable semantic highlighting for some LSPs
    for _, name in ipairs({ "dockerls" }) do
      if client.name == name then client.server_capabilities.semanticTokensProvider = nil end
    end
    -- Disable hover for some LSPs
    for _, name in ipairs({ "ruff_lsp" }) do
      if client.name == name then client.server_capabilities.hoverProvider = nil end
    end
    -- Disable formatting for some LSPs
    for _, name in ipairs({ "jsonls", "biome", "tsserver", "vtsls", "basedpyright" }) do
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
vim.filetype.add({ filename = { [".ignore"] = "gitignore" } })
vim.filetype.add({ pattern = { ["queries/.*%.scm"] = "query" } })
vim.filetype.add({ pattern = { ["%.husky/.*"] = "sh" } })
vim.filetype.add({ extension = { ["gitconfig"] = "gitconfig" } })
vim.filetype.add({ pattern = { ["%.env%..*"] = "sh" } })
vim.filetype.add({ extension = { ["add"] = "conf" } })
vim.filetype.add({ pattern = { ["%.default%-%w+%-packages"] = "conf" } })
vim.filetype.add({ extension = { ["jinja"] = "jinja", ["jinja2"] = "jinja", ["j2"] = "jinja" } })
vim.filetype.add({ pattern = { [".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.github" } })

--------------------------
-- lazy.nvim configuration
--------------------------
local packages_path = vim.fn.stdpath("data") .. "/lazy"

-- Helper function to install packages before lazy.nvim is loaded
---@param name string
---@param alias string?
local function install_package(name, alias)
  ---@type unknown, unknown, string, string
  local _, _, owner, repo = name:find("(.+)/(.+)")
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

require("lazy").setup({
  spec = {
    { import = "packages" },
  },
  install = { colorscheme = { "catppuccin-mocha" } },
  change_detection = { notify = false },
  ui = { backdrop = 100, border = border },
})
