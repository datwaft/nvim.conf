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

local spell_active = false

---@param win_id  integer
---@param buf_id? integer Buffer captured by a scheduled callback.
local function update_spell(win_id, buf_id)
  if not vim.api.nvim_win_is_valid(win_id) then return end
  local current_buf = vim.api.nvim_win_get_buf(win_id)
  if buf_id and current_buf ~= buf_id then return end
  local disabled = vim.api.nvim_win_get_config(win_id).relative ~= ""
    or vim.bo[current_buf].buftype ~= ""
    or vim.list_contains(spell_disabled_filetypes, vim.bo[current_buf].filetype)

  if disabled then
    vim.wo[win_id][0].spell = false
  elseif spell_active then
    vim.wo[win_id][0].spell = true
  end
end

local function sync_spell_files()
  for _, wordlist in ipairs(vim.opt.spellfile:get()) do
    local add_mtime = vim.uv.fs_stat(wordlist)?.mtime.sec
    if add_mtime and add_mtime > (vim.uv.fs_stat(wordlist .. ".spl")?.mtime.sec ?? -1) then
      vim.cmd({ cmd = "mkspell", args = { wordlist }, bang = true, mods = { silent = true } })
    end
  end
end

local function activate_spell()
  sync_spell_files()
  spell_active = true
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    update_spell(win_id)
  end
end

local spell_group = vim.api.nvim_create_augroup("spell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "TermOpen" }, {
  group = spell_group,
  callback = function(args)
    local win_id = args.win or vim.api.nvim_get_current_win()
    vim.schedule(function()
      update_spell(win_id, args.buf)
    end)
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = spell_group,
  callback = function(args)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then return end
      for _, win_id in ipairs(vim.fn.win_findbuf(args.buf)) do
        update_spell(win_id, args.buf)
      end
    end)
  end,
})
-- Load dictionaries after startup without enabling `spell` globally.
vim.api.nvim_create_autocmd("User", {
  group = spell_group,
  pattern = "VeryLazy",
  once = true,
  callback = activate_spell,
})
