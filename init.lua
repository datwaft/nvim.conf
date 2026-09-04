-----------
-- Settings
-----------
-- Enable experimental bytecode cache
vim.loader.enable()
-- Enable experimental command line
if not vim.g.vscode then require("vim._core.ui2").enable({}) end
-- Set <leader> to '\'
vim.g.mapleader = [[\]]
-- Set <localleader> to <SPACE>
vim.g.maplocalleader = [[ ]]
-- Swap
vim.o.swapfile = false
-- Indentation
vim.o.expandtab = true
vim.o.shiftwidth = 0
vim.o.tabstop = 2
-- Wrapping
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = { "shift:0" }
vim.o.showbreak = "↳ "
-- Folding
vim.o.foldtext = ""
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.o.fillchars = {
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  foldinner = " ",
  diff = "/",
}
-- Undo persistence
vim.o.undofile = true
-- Enable local configuration
vim.o.exrc = true
-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
-- Scrolling
vim.o.splitkeep = "screen"
vim.o.smoothscroll = true
vim.o.scrolloff = 7
-- Command-line
vim.o.showmode = false
-- Whitespace
vim.o.list = true
vim.o.listchars = {
  trail = "·",
  tab = "→ ",
  nbsp = "·",
}
-- Spell-checking
vim.o.spell = true
vim.o.spelllang = { "programming", "en", "es", "cjk", "el" }
vim.o.spellfile = {
  vim.fn.stdpath("config") .. "/spell/programming.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/es.utf-8.add",
}
vim.o.spelloptions = "camel"
vim.o.spellcapcheck = ""
-- Sign column
vim.o.signcolumn = "yes:1"
-- Insert-mode completion
vim.opt.shortmess:append("c")
-- Grep
vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob='!.git/*'"
vim.o.grepformat = "%f:%l:%c:%m"
-- Find
---@param file_pattern string
function _G.findfunc(file_pattern, _)
  -- if first character is '*' then fuzzy search
  if file_pattern:sub(1, 1) == "*" then file_pattern = file_pattern:gsub(".", ".*%0") .. ".*" end
  local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
  return vim.fn.systemlist(cmd)
end
vim.o.findfunc = "v:lua.findfunc"
-- Mouse
vim.o.mousemodel = "extend"
vim.o.mousescroll = "ver:2,hor:0"
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleMouse>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleDrag>", "<Nop>")
vim.keymap.set({ "n", "v", "o", "c", "i" }, "<MiddleRelease>", "<Nop>")
-- Link identification
vim.opt.isfname:append({ "*", "[", "]" })

---------------
-- Autocommands
---------------
-- Open quickfix window when populated
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("open-quickfix-when-populated", { clear = true }),
  callback = function()
    vim.defer_fn(function()
      vim.cmd("botright cwindow")
    end, 10)
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
    vim.wo.number = false
    vim.wo.relativenumber = false
    -- Disable spell checking
    vim.wo.spell = false
    -- Disable sign column
    vim.wo.signcolumn = "no"
    -- Disable colorcolumn
    vim.wo.colorcolumn = {}
  end,
})
-- When entering the terminal start in insert mode
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  group = vim.api.nvim_create_augroup("terminal-enter", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].buftype == "terminal" then vim.cmd.startinsert() end
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
    "jjdescription",
    "codediff-explorer",
  },
  callback = function()
    vim.wo.spell = false
  end,
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
    if config.relative == "" then vim.wo.spell = true end
  end,
})
-- Always enable 'conceallevel' on some filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("enable-conceal", { clear = true }),
  pattern = { "html" },
  callback = function()
    vim.wo.conceallevel = 2
  end,
})

-----------
-- Keybinds
-----------
-- Remove word with <M-BS>
vim.keymap.set({ "i", "c", "t" }, "<M-BS>", "<C-w>")
-- Go to folder with -
vim.keymap.set("n", "-", "<CMD>e %:h<CR>")
-- Disable highlights with <ESC>
vim.keymap.set(
  "n",
  "<ESC>",
  [[<ESC><CMD>nohlsearch | diffupdate | call nvim_buf_clear_namespace(0, nvim_create_namespace("nvim.multicursor"), 0, -1)<CR>]]
)
-- Make mappings similar to TMUX mappings for Vim tabs
vim.keymap.set("n", "<C-t>n", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-t>s", "<CMD>tabs<CR>")
vim.keymap.set("n", "<C-t>[", "<CMD>tabnext<CR>")
vim.keymap.set("n", "<C-t>]", "<CMD>tabprevious<CR>")
vim.keymap.set("n", "<C-t>w", "<CMD>tabclose<CR>")
vim.keymap.set("n", "<C-t>q", "<CMD>tabclose<CR>")
-- Enter normal mode in terminal with <ESC><ESC>
vim.keymap.set("t", "<ESC><ESC>", [[<C-\><C-n>]])
-- Navigate between windows using <C-w>hjkl in terminal mode
vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><cmd>wincmd h<cr>]])
vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><cmd>wincmd j<cr>]])
vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><cmd>wincmd k<cr>]])
vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><cmd>wincmd l<cr>]])
-- Close wildmenu using <SPACE>
vim.keymap.set(
  "c",
  "<SPACE>",
  || -> vim.fn.wildmenumode() == 1 ? "<C-y>" : "<SPACE>",
  { expr = true }
)
-- Make `j` work with wrapped lines
vim.keymap.set({ "n", "v" }, "j", || -> vim.v.count == 0 ? "gj" : "m'" .. vim.v.count .. "j", { expr = true })
-- Make `k` work with wrapped lines
vim.keymap.set({ "n", "v" }, "k", || -> vim.v.count == 0 ? "gk" : "m'" .. vim.v.count .. "k", { expr = true })
-- Make `<Up>` work with wrapped lines
vim.keymap.set({ "n", "v" }, "<Up>", || -> vim.v.count == 0 ? "gk" : "m'" .. vim.v.count .. "<Up>", { expr = true })
-- Make `<Down>` work with wrapped lines
vim.keymap.set({ "n", "v" }, "<Down>", || -> vim.v.count == 0 ? "gj" : "m'" .. vim.v.count .. "<Down>", { expr = true })
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
end, { silent = true }
)
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
end, { silent = true }
)
-- Copy current file path to clipboard modified to work with playwright
vim.keymap.set("n", "<leader>L", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:~:.:s?tests/??"))
  vim.notify(("'%s' was copied to clipboard"):format(vim.fn.getreg("+")), vim.log.levels.INFO)
end, { silent = true }
)
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
end, { silent = true }
)

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
}
vim.o.winborder = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }

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
  "actionsls",
  "autotools_ls",
  "bashls",
  "bg3",
  "biome",
  "clangd",
  "cmake",
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
  "ty",
  "vimdoc_ls",
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

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      telemetry = { enable = false },
      hint = { enable = true },
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

vim.lsp.config("vtsls", {
  settings = {
    typescript = { tsserver = { pluginPaths = { "./node_modules" } } },
    vtsls = { autoUseWorkspaceTsdk = true },
  },
})

vim.lsp.config("ts_query_ls", {
  settings = {
    parser_install_directories = {
      vim.fn.stdpath("data") .. "/site/parser/",
    },
  },
})

vim.lsp.config("tsgo", {
  settings = {
    ["js/ts"] = {
      inlayHints = {
        parameterTypes = { enabled = false },
        variableTypes = { enabled = false },
      },
    },
  },
})

vim.lsp.config("taplo", {
  root_markers = { ".taplo.toml", "taplo.toml", ".git", "starship.toml" },
})

vim.lsp.config("bg3", {
  cmd = { "bg3-ls" },
  filetypes = { "bg3_stats", "bg3_lsx", "bg3_thoth", "bg3_osiris", "bg3_localization" },
  workspace_required = true,
  root_dir = function(_, on_dir)
    on_dir(vim.fs.root(vim.uv.cwd(), "bg3-ls.json"))
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach-config", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    -- Show hover documentation
    vim.keymap.set("n", "K", function()
      if #vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" }) > 0 then
        require("custom.verbose-hover").hover()
      else
        vim.lsp.buf.hover()
      end
    end, { buffer = bufnr }
    )
    -- Show signature help
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr })
    -- Code actions
    vim.keymap.set({ "n", "x" }, "gra", [[<cmd>lua require("fastaction").code_action()<CR>]], { buffer = bufnr })
    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gD", "<cmd>Glance definitions<cr>", { buffer = bufnr })
    -- Go to type definition
    vim.keymap.set("n", "gt", function()
      vim.lsp.buf.type_definition({
        on_list = function(t)
          vim.lsp.util.show_document(t.items[1].user_data, "utf-8", { focus = true })
        end,
      })
    end, { buffer = bufnr }
    )
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
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, { buffer = bufnr }
      )
    end
    -- Run codelens
    vim.keymap.set("n", "grl", function()
      vim.lsp.codelens.run({ client_id = client.id })
    end, { buffer = bufnr }
    )
    -- Toggle codelens
    vim.keymap.set("n", "<leader>tl", function()
      vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, { buffer = bufnr }
    )
    -- Toggle inline completion
    vim.keymap.set("n", "<leader>ti", function()
      vim.lsp.inline_completion.enable(
        not vim.lsp.inline_completion.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
      )
    end, { buffer = bufnr }
    )
    -- Enable inlay hints by default
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- Disable codelens by default
    vim.lsp.codelens.enable(false, { bufnr = bufnr })
    -- Use LSP-provided color if possible
    vim.lsp.document_color.enable(true, { bufnr = bufnr })
    -- Enable inline completion if possible (except on some filetypes)
    local enable_inline = not vim.list_contains({ "fennel" }, vim.bo[bufnr].filetype)
    vim.lsp.inline_completion.enable(enable_inline, { bufnr = bufnr })
    -- Enable linked editing range if possible
    if client:supports_method("textDocument/linkedEditingRange") then
      vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end
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
vim.filetype.add({ pattern = { [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions" } })
vim.filetype.add({ pattern = { [".*/%.github/actions/.*/action%.ya?ml"] = "yaml.ghactions" } })

--------------------------
-- lazy.nvim configuration
--------------------------
const packages_path = vim.fn.stdpath("data") .. "/lazy"

-- Helper function to install packages before lazy.nvim is loaded
---@param name  string
---@param alias string?
local function install_package(name, alias)
  ---@type unknown, unknown, string, string
  local _, _, owner, repo = name:find("(.+)/(.+)")
  local path = ("%s/%s"):format(packages_path, alias ?? repo)

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
    { import = "packages", cond = || -> not vim.g.vscode },
    { import = "packages.editing", cond = || -> vim.g.vscode },
    { import = "packages.movement", cond = || -> vim.g.vscode },
  },
  install = { colorscheme = { "rose-pine" } },
  change_detection = { notify = false },
  ui = { backdrop = 100, border = vim.opt.winborder:get() },
})
