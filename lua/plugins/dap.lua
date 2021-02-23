-- ======================
-- NVIM-DAP CONFIGURATION
-- ======================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end
  ---------------------
  -- Keyboards mappings
  ---------------------
    vimp.nnoremap(
      {'override'},
      '<A-t>',
      [[:lua require'dap'.toggle_breakpoint()]]
    )
    vimp.nnoremap(
      {'override'},
      '<A-c>',
      [[:lua require'dap'.continue()]]
    )
    vimp.nnoremap(
      {'override'},
      '<A-s>',
      [[:lua require'dap'.step_over()]]
    )
    vimp.nnoremap(
      {'override'},
      '<A-g>',
      [[:lua require'dap'.step_into()]]
    )
    vimp.nnoremap(
      {'override'},
      '<A-i>',
      [[:lua require'dap'.repl.open()]]
    )
  -----------------------------
  -- Virtual text configuration
  -----------------------------
    vim.g.dap_virtual_text = true
  ---------------------
  -- Sign configuration
  ---------------------
    vim.fn.sign_define('DapBreakpoint',
      {text='🛑', texthl='', linehl='', numhl=''})
  ---------------------------
  -- C/C++/Rust configuration
  ---------------------------
    local dap = require'dap'
    dap.adapters.cpp = {
      type = 'executable',
      attach = {
        pidProperty = 'pid',
        pidSelect = 'ask',
      },
      command = 'lldb-vscode',
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
      },
      name = 'lldb',
    }
end
