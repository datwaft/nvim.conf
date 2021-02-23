-- ============================
-- LSP EXTENSIONS CONFIGURATION
-- ============================
-- Created by datwaft <github.com/datwaft>

return function()
  local autocmd = require'core.autocmd'
  autocmd {
    events = { 'CursorHold', 'CursorHoldI' },
    pattern = '*.rs',
    command = [[:lua require'lsp_extensions'.inlay_hints{
      only_current_line = true
    }]]
  }
end

