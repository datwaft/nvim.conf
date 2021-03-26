-- =======================
-- TELESCOPE CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end
  vimp.nnoremap({'override'}, '<leader>ff', '<cmd>Telescope find_files<cr>')
  vimp.nnoremap({'override'}, '<leader>fg', '<cmd>Telescope live_grep<cr>')
  vimp.nnoremap({'override'}, '<leader>fb', '<cmd>Telescope buffers<cr>')
  vimp.nnoremap({'override'}, '<leader>fh', '<cmd>Telescope help_tags<cr>')
  vimp.nnoremap({'override'}, '<leader>fa', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
  vimp.nnoremap({'override'}, '<leader>fr', '<cmd>Telescope lsp_references<cr>')
  vimp.nnoremap({'override'}, '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>')
  vimp.nnoremap({'override'}, '<leader>f<C-s>', '<cmd>Telescope lsp_workspace_symbols<cr>')

  local actions = require'telescope.actions'
  require'telescope'.setup {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-q>"] = actions.close,
          ["<M-q>"] = actions.close,
        }
      }
    }
  }
end
