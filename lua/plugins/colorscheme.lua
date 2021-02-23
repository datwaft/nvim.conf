-- =========================
-- COLORSCHEME CONFIGURATION
-- =========================
-- Created by datwaft <github.com/datwaft>

return function()
   -- Set style
   vim.g.edge_style = 'default'
   vim.g.edge_enable_italic = 1
   vim.g.edge_current_word  = 'underline'
   -- Set colorscheme
   vim.cmd [[ colorscheme edge ]]
end
