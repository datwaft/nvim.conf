-- =======================
-- VIM SLIME CONFIGURATION
-- =======================
-- Created by datwaft [github.com/datwaft]

return function()
   if not pcall(require, 'vimp') then
      vim.cmd [[ echom 'Cannot load `vimp`' ]]
      return
   end

   vim.g.slime_target = 'tmux'
   vim.g.slime_python_ipython = 1
   vimp.nmap('<leader>s', '<Plug>SlimeMotionSend')
   vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
end
