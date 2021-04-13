-- =======================
-- TELESCOPE CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end

  local prerequire = require'utils.prerequire'
  local io = require'utils.io'

  local telescope = prerequire'telescope'
  if not telescope then
    io.warning"Couldn't load `telescope` package"
    return
  end

  local builtin = prerequire'telescope.builtin'
  if not builtin then
    io.warning"Couldn't load `telescope.builtin` package"
    return
  end

  local actions = prerequire'telescope.actions'
  if not actions then
    io.warning"Couldn't load `telescope.actions` package"
    return
  end

  vimp.nnoremap({'override'}, '<leader>ff', function()
    local opts = {}
    local ok = pcall(builtin.git_files, opts)
    if not ok then builtin.find_files(opts) end
  end)
  vimp.nnoremap({'override'}, '<leader>fg', '<cmd>Telescope live_grep<cr>')
  vimp.nnoremap({'override'}, '<leader>fb', '<cmd>Telescope buffers<cr>')
  vimp.nnoremap({'override'}, '<leader>fh', '<cmd>Telescope help_tags<cr>')
  vimp.nnoremap({'override'}, '<leader>fa', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
  vimp.nnoremap({'override'}, '<leader>fr', '<cmd>Telescope lsp_references<cr>')
  vimp.nnoremap({'override'}, '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>')
  vimp.nnoremap({'override'}, '<leader>f<C-s>', '<cmd>Telescope lsp_workspace_symbols<cr>')

  telescope.setup {
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
