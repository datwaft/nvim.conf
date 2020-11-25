-- =======================
-- VIM SLIME CONFIGURATION
-- =======================
-- Created by datwaft [github.com/datwaft]

if pcall(require, 'vimp') then
   return function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_python_ipython = 1
      vimp.nmap('<leader>s', '<Plug>SlimeMotionSend')
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
   end
else
   return function()
      vim.cmd [[ echom 'Cannot load `vimp`' ]]
   end
end
