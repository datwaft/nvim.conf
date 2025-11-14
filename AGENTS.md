# Neovim Configuration Agent Guidelines

## Build/Lint/Test Commands
- **Format check**: `stylua --check .`
- **Format apply**: `stylua .` (runs automatically in pre-commit via Husky)
- **Motion dependency**: `chrisgrieser/nvim-spider` requires the external `luautf8` library for UTF-8 motions.
- **Git hooks**: install via `npx husky` (details and extra dependencies live in `README.md`).
- **Update plugins**: `:Lazy update` in Neovim
- **No automated tests** - manual validation by launching Neovim

## Code Style Guidelines
- **Indentation**: 2 spaces, LuaJIT syntax (`.stylua.toml` enforced)
- **Module pattern**: Each `lua/packages/*.lua` returns `---@type LazySpec` table
- **Plugin imports**: Top-level `init.lua` uses `{ import = "packages.module_name" }`
- **Naming**: snake_case for files/vars/functions, PascalCase for plugin names
- **Type annotations**: Always use `---@type`, `---@param`, `---@return` for LuaLS
- **Global functions**: Define in `_G` namespace (e.g., `function _G.define_sign()`)
- **Keybindings**: `vim.keymap.set()` with descriptive names, follow `<leader>\` and `<localleader><Space>`
- **Autocommands**: Always use named groups: `vim.api.nvim_create_augroup("name", { clear = true })`
- **LSP config**: Use modern `vim.lsp.enable()` and `vim.lsp.config()` API (Neovim 0.11+)
- **Error handling**: Fail loudly, no `pcall()` unless explicit requirement
- **Snippets**: SnipMate-format snippets live in `snippets/*.snippets` (TypeScript extends JavaScript); prefer editing those files over inline snippet definitions.
- **Spell files**: Add domain-specific terms to `spell/programming.utf-8.add`, `spell/en.utf-8.add`, or `spell/es.utf-8.add` instead of disabling spell-check.

## Architecture
- **Package manager**: lazy.nvim with version pinning (check `lazy-lock.json` before updates)
- **Modular structure**: Add features to the appropriate `lua/packages/*.lua` module (aesthetic, completion, debugging, etc.)
- **Custom queries**: TreeSitter overrides in `after/queries/{lang}/`
- **Filetype configs**: Language-specific settings in `after/ftplugin/{lang}.lua`
- **Compiler definitions**: `compiler/biome.lua` and `compiler/actionlint.lua` show the required `vim.fn.exists("current_compiler")` guard and format for new compilers.
- **LSP servers**: 20+ preconfigured (`lua_ls`, `basedpyright`, `biome`, etc.) - check existing before adding
- **Git**: Conventional Commits enforced via commitlint (feat/fix/docs/refactor/test/chore)
