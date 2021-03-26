-- =====================
-- LSPSAGA CONFIGURATION
-- =====================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end

  local saga = require'lspsaga'
  saga.init_lsp_saga {
    code_action_prompt = {
      enable = true,
      sign = false,
      sign_priority = 20,
      virtual_text = true,
    },
    code_action_keys = {
      quit = 'q',exec = '<CR>'
    },
    rename_action_keys = {
      quit = '<M-q>',exec = '<CR>'
    },
  }

  ---------
  -- Finder
  ---------
    vimp.nnoremap(
      {'override', 'silent'},
      'gh',
      [[<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>]]
    )
  --------------
  -- Code action
  --------------
    vimp.nnoremap(
      {'override', 'silent'},
      '<leader>a',
      [[<cmd>lua require'lspsaga.codeaction'.code_action()<cr>]]
    )
    vimp.vnoremap(
      {'override', 'silent'},
      '<leader>a',
      [[<cmd>'<,'>lua require'lspsaga.codeaction'.code_action()<cr>]]
    )
  ----------------
  -- Documentation
  ----------------
    -- Show documentation
    vimp.nnoremap(
      {'override', 'silent'},
      'K',
      [[<cmd>lua require'lspsaga.hover'.render_hover_doc()<cr>]]
    )
    -- Scroll down
    vimp.nnoremap(
      {'override', 'silent'},
      '<C-f>',
      [[<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<cr>]]
    )
    -- Scroll up
    vimp.nnoremap(
      {'override', 'silent'},
      '<C-b>',
      [[<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<cr>]]
    )
  -----------------
  -- Show signature
  -----------------
  vimp.nnoremap(
    {'override', 'silent'},
    'gs',
    [[<cmd>lua require'lspsaga.signaturehelp'.signature_help()<cr>]]
  )
  ---------
  -- Rename
  ---------
    vimp.nnoremap(
      {'override', 'silent'},
      '<leader>rn',
      [[<cmd>lua require'lspsaga.rename'.rename()<cr>]]
    )
  ---------------------
  -- Preview definition
  ---------------------
    vimp.nnoremap(
      {'override', 'silent'},
      'gd',
      [[<cmd>lua require'lspsaga.provider'.preview_definition()<cr>]]
    )
  --------------
  -- Diagnostics
  --------------
    -- Show diagnostics
    vimp.nnoremap(
      {'override', 'silent'},
      '<leader>d',
      [[<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>]]
    )
    -- Jump between diagnostics
    vimp.nnoremap(
      {'override', 'silent'},
      ']e',
      [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>]]
    )
    vimp.nnoremap(
      {'override', 'silent'},
      '[e',
      [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>]]
    )
end
