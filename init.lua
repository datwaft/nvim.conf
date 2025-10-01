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
-- Enable experimental bytecode cache
vim.loader.enable()
-- Enable experimental command line
require("vim._extui").enable({})
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
vim.opt.breakindentopt = { "shift:0" }
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
vim.opt.spelllang = { "programming", "en", "es", "cjk", "el" }
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
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --glob='!.git/*'"
vim.opt.grepformat = "%f:%l:%c:%m"
-- Find
---@param file_pattern string
function _G.findfunc(file_pattern, _)
  -- if first character is '*' then fuzzy search
  if file_pattern:sub(1, 1) == "*" then file_pattern = file_pattern:gsub(".", ".*%0") .. ".*" end
  local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
  return vim.fn.systemlist(cmd)
end
vim.opt.findfunc = "v:lua.findfunc"
-- Mouse
vim.opt.mousemodel = "extend"
vim.opt.mousescroll = "ver:2,hor:0"
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleDrag>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleRelease>", "<Nop>")
-- Link identification
vim.opt.isfname:append("*")
vim.opt.isfname:append("[")
vim.opt.isfname:append("]")

---------------
-- Autocommands
---------------
-- Open quickfix window when populated
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("open-quickfix-when-populated", { clear = true }),
  callback = function()
    vim.defer_fn(function() vim.cmd("botright cwindow") end, 10)
  end,
})
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
  callback = function()
    local win_id = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win_id)
    if config.relative == "" then vim.opt_local.spell = true end
  end,
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
-- Remove word with <M-BS>
vim.keymap.set({ "i", "c", "t" }, "<M-BS>", "<C-w>")
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
    return "m'" .. vim.v.count .. "j"
  end
end, { expr = true })
-- Make `k` work with wrapped lines
vim.keymap.set({ "n", "v" }, "k", function()
  if vim.v.count == 0 then
    return "gk"
  else
    return "m'" .. vim.v.count .. "k"
  end
end, { expr = true })
-- Make `<Up>` work with wrapped lines
vim.keymap.set({ "n", "v" }, "<Up>", function()
  if vim.v.count == 0 then
    return "gk"
  else
    return "m'" .. vim.v.count .. "<Up>"
  end
end, { expr = true })
-- Make `<Down>` work with wrapped lines
vim.keymap.set({ "n", "v" }, "<Down>", function()
  if vim.v.count == 0 then
    return "gj"
  else
    return "m'" .. vim.v.count .. "<Down>"
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
-- Copy current file path to clipboard
vim.keymap.set("n", "<leader>l", function()
  vim.fn.setreg("+", vim.fn.expand("%:."))
  vim.notify(("'%s' was copied to clipboard"):format(vim.fn.getreg("+")), vim.log.levels.INFO)
end, { silent = true })
-- Copy current location to clipboard
vim.keymap.set("x", "<leader>l", function()
  local path = vim.fn.expand("%:.")

  local srow = vim.fn.line("v")
  local erow = vim.fn.line(".")
  if srow > erow then
    srow, erow = erow, srow
  end

  if srow == erow then
    vim.fn.setreg("+", ("%s:%d"):format(path, srow))
  else
    vim.fn.setreg("+", ("%s:%d-%d"):format(path, srow, erow))
  end
  vim.notify(("'%s' was copied to clipboard"):format(vim.fn.getreg("+")), vim.log.levels.INFO)
end, { silent = true })
-- Copy current file path to clipboard modified to work with playwright
vim.keymap.set("n", "<leader>L", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:~:.:s?tests/??"))
  vim.notify(("'%s' was copied to clipboard"):format(vim.fn.getreg("+")), vim.log.levels.INFO)
end, { silent = true })
-- Copy current location to clipboard modified to work with playwright
vim.keymap.set("x", "<leader>L", function()
  local path = vim.fn.expand("%:p:~:.:s?tests/??")

  local srow = vim.fn.line("v")
  local erow = vim.fn.line(".")
  if srow > erow then
    srow, erow = erow, srow
  end

  if srow == erow then
    vim.fn.setreg("+", ("%s:%d"):format(path, srow))
  else
    vim.fn.setreg("+", ("%s:%d-%d"):format(path, srow, erow))
  end
  vim.notify(("'%s' was copied to clipboard"):format(vim.fn.getreg("+")), vim.log.levels.INFO)
end, { silent = true })

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
vim.opt.winborder = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }

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
vim.lsp.enable({
  "autotools_ls",
  "basedpyright",
  "bashls",
  "biome",
  "clangd",
  "cmake",
  "copilot",
  "cssls",
  "dockerls",
  "fennel_ls",
  "graphql",
  "html",
  "jdtls",
  "jinja_lsp",
  "jsonls",
  "lua_ls",
  "ruff",
  "rust_analyzer",
  "svelte",
  "taplo",
  "texlab",
  "ts_query_ls",
  "vimls",
  "vtsls",
  "yamlls",
})

vim.lsp.config("basedpyright", {
  -- See https://docs.basedpyright.com/v1.28.1/configuration/language-server-settings/#based-settings
  settings = {
    basedpyright = {
      analysis = {
        inlayHints = {
          callArgumentNames = false,
        },
      },
    },
  },
})

vim.lsp.config("texlab", {
  settings = {
    texlab = {
      build = {
        executable = "tectonic",
        args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
})

vim.lsp.config("vtsls", {
  settings = { vtsls = { autoUseWorkspaceTsdk = true } },
})

vim.lsp.config("ts_query_ls", {
  settings = {
    parser_install_directories = {
      vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/",
    },
    language_retrieval_patterns = {
      "languages/src/([^/]+)/[^/]+\\.scm$",
    },
  },
})

vim.lsp.config("taplo", {
  root_markers = { ".taplo.toml", "taplo.toml", ".git", "starship.toml" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach-config", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- Show hover documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    -- Show signature help
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr })
    -- Code actions
    vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, { buffer = bufnr })
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
    -- Toggle inline completion
    vim.keymap.set(
      "n",
      "<leader>ti",
      function()
        vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end,
      { buffer = bufnr }
    )

    -- Enable inlay hints by default
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- Use LSP-provided color if possible
    vim.lsp.document_color.enable(true, bufnr)
    -- Enable inline completion if possible
    vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

    -- Disable semantic highlighting for some LSPs
    for _, name in ipairs({ "dockerls" }) do
      if client.name == name then client.server_capabilities.semanticTokensProvider = nil end
    end
    -- Disable hover for some LSPs
    for _, name in ipairs({ "ruff" }) do
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
  ui = { backdrop = 100, border = vim.opt.winborder:get() },
})
