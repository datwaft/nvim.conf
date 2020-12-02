-- =========================
-- COLORSCHEME CONFIGURATION
-- =========================
-- Created by datwaft [github.com/datwaft]

return function()
   -- Activate 24 bit colors
   vim.o.termguicolors = true
   -- Set style
   vim.g.edge_style = 'default'
   vim.g.edge_enable_italic = 1
   vim.g.edge_current_word  = 'underline'
   -- Set colorscheme
   vim.cmd [[ colorscheme edge ]]
   -- Set lightline theme
   vim.g.statusline_theme = 'edge'
end
