-- ==================
-- REVJ CONFIGURATION
-- ==================
-- Created by datwaft <github.com/datwaft>

return function()
  require("revj").setup{
    brackets = { first = '([{<', last = ')]}>' },
    new_line_before_last_bracket = true,
    enable_default_keymaps = false,
    keymaps = {
        operator = '<Leader>J',
        line = '<Leader>j',
        visual = '<Leader>j',
    },
  }
end
