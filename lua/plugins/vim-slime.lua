-- =======================
-- VIM-SLIME CONFIGURATION
-- =======================
-- Created by datwaft <github.com/datwaft>

return function()
  if not vimp then
    return
  end
  vim.g.slime_target = 'tmux'
  vim.g.slime_python_ipython = 1
  vimp.nmap({'override'}, '<leader>s', '<Plug>SlimeMotionSend')
  vim.g.slime_default_config = {
    socket_name = "default",
    target_pane = "{last}"
  }
end
