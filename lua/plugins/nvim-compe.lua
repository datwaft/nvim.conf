-- ========================
-- NVIM-COMPE CONFIGURATION
-- ========================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end

  local options = require'core.options'

  options.completeopt = 'menuone,noselect'

  require'compe'.setup {
    enabled = true,
    autocomplete = false,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = true,
      buffer = true,
      calc = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
      tags = true,
      snippets_nvim = true,
      treesitter = true,
    },
  }
  
  vimp.inoremap(
    {'override', 'silent', 'expr'},
    '<C-Space>',
    [[compe#complete()]]
  )
  vimp.inoremap(
    {'override', 'silent', 'expr'},
    '<space>',
    [[compe#confirm('<Space>')]]
  )
  vimp.inoremap(
    {'override', 'silent', 'expr'},
    '<C-e>',
    [[compe#close('<C-e>')]]
  )
  vimp.inoremap(
    {'override', 'silent', 'expr'},
    '<C-f>',
    [[compe#scroll({ 'delta': +4 })]]
  )
  vimp.inoremap(
    {'override', 'silent', 'expr'},
    '<C-d>',
    [[compe#scroll({ 'delta': -4 })]]
  )

  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
  end
  vimp.inoremap({'override', 'expr'}, '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-n>'
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
      return "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
      return '<Tab>'
    else
      return vim.fn['compe#complete']()
    end
  end)
  vimp.snoremap({'override', 'expr'}, '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-n>'
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
      return "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
      return '<Tab>'
    else
      return vim.fn['compe#complete']()
    end
  end)
  vimp.inoremap({'override', 'expr'}, '<S-Tab>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-p>'
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return '<S-Tab>'
    end
  end)
  vimp.snoremap({'override', 'expr'}, '<S-Tab>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-p>'
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
      return t "<Plug>(vsnip-jump-prev)"
    else
      return '<S-Tab>'
    end
  end)
end
