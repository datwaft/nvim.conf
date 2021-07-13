(module core.plugin.tmux
  {autoload {plugin tmux
             m vimp}})

(plugin.setup {:copy_sync {:enable false}
               :navigation {:enable_default_keybindings false}
               :resize {:enable_default_keybindings false}})

(m.nnoremap [:override :silent] "<C-w>h" "<cmd>lua require('tmux').move_left()<cr>")
(m.nnoremap [:override :silent] "<C-w>j" "<cmd>lua require('tmux').move_bottom()<cr>")
(m.nnoremap [:override :silent] "<C-w>k" "<cmd>lua require('tmux').move_top()<cr>")
(m.nnoremap [:override :silent] "<C-w>l" "<cmd>lua require('tmux').move_right()<cr>")

(m.nnoremap [:override :silent] "<M-h>" "<cmd>lua require('tmux').resize_left()<cr>")
(m.nnoremap [:override :silent] "<M-j>" "<cmd>lua require('tmux').resize_bottom()<cr>")
(m.nnoremap [:override :silent] "<M-k>" "<cmd>lua require('tmux').resize_top()<cr>")
(m.nnoremap [:override :silent] "<M-l>" "<cmd>lua require('tmux').resize_right()<cr>")
