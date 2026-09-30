-- Spell-checking
vim.o.spell = false
vim.o.spelllang = { "programming", "en", "es", "cjk", "el" }
vim.o.spellfile = {
  vim.fn.stdpath("config") .. "/spell/programming.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/es.utf-8.add",
}
vim.o.spelloptions = "camel"
vim.o.spellcapcheck = ""

-- Always disable `spell` on some filetypes
local spell_disabled_filetypes = {
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
}

---@param win_id integer
---@param buf_id? integer Buffer captured by a scheduled FileType callback.
local function enable_spell(win_id, buf_id)
  if not vim.api.nvim_win_is_valid(win_id) then return end
  local current_buf = vim.api.nvim_win_get_buf(win_id)
  if buf_id and current_buf ~= buf_id then return end
  if vim.api.nvim_win_get_config(win_id).relative ~= "" then return end
  if vim.bo[current_buf].buftype == "terminal" then return end
  if vim.list_contains(spell_disabled_filetypes, vim.bo[current_buf].filetype) then return end

  vim.wo[win_id].spell = true
end

local function activate_spell()
  vim.go.spell = true
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    enable_spell(win_id)
  end
  vim.cmd.SpellSync()
end

local spell_group = vim.api.nvim_create_augroup("spell", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = spell_group,
  pattern = spell_disabled_filetypes,
  callback = function()
    vim.wo.spell = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = spell_group,
  pattern = { "markdown", "tex", "quarto" },
  callback = function(args)
    local win_id = vim.api.nvim_get_current_win()
    vim.schedule(function() enable_spell(win_id, args.buf) end)
  end,
})
-- Load dictionaries after startup without overriding window-specific exclusions.
vim.api.nvim_create_autocmd("User", {
  group = spell_group,
  pattern = "VeryLazy",
  once = true,
  callback = activate_spell,
})
