(module core.plugin.tmux
  {autoload {plugin tmux}
   require-macros [core.macros]})

(plugin.setup {:copy_sync {:enable false}
               :navigation {:enable_default_keybindings false}
               :resize {:enable_default_keybindings false}})

(noremap! [n :silent] "<C-w>h" "<cmd>lua require('tmux').move_left()<cr>")
(noremap! [n :silent] "<C-w>j" "<cmd>lua require('tmux').move_bottom()<cr>")
(noremap! [n :silent] "<C-w>k" "<cmd>lua require('tmux').move_top()<cr>")
(noremap! [n :silent] "<C-w>l" "<cmd>lua require('tmux').move_right()<cr>")

(noremap! [n :silent] "<M-h>" "<cmd>lua require('tmux').resize_left()<cr>")
(noremap! [n :silent] "<M-j>" "<cmd>lua require('tmux').resize_bottom()<cr>")
(noremap! [n :silent] "<M-k>" "<cmd>lua require('tmux').resize_top()<cr>")
(noremap! [n :silent] "<M-l>" "<cmd>lua require('tmux').resize_right()<cr>")
