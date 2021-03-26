-- =========================
-- SPELLSITTER CONFIGURATION
-- =========================
-- Created by datwaft <github.com/datwaft>

return function()
  require'spellsitter'.setup {
    hl = 'SpellBad',
    captures = { 'comment' },
    hunspell_cmd = 'hunspell',
    hunspell_args = {},
  }
end
