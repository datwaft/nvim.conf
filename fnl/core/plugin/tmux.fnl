(module core.plugin.tmux
  {autoload {plugin tmux}
   require-macros [core.macros]})

(plugin.setup {:copy_sync {:enable false}
               :navigation {:enable_default_keybindings false}
               :resize {:enable_default_keybindings false}})

(noremap! [n] "<C-w>h" "<cmd>lua require('tmux').move_left()<cr>" :silent)
(noremap! [n] "<C-w>j" "<cmd>lua require('tmux').move_bottom()<cr>" :silent)
(noremap! [n] "<C-w>k" "<cmd>lua require('tmux').move_top()<cr>" :silent)
(noremap! [n] "<C-w>l" "<cmd>lua require('tmux').move_right()<cr>" :silent)

(noremap! [n] "<M-h>" "<cmd>lua require('tmux').resize_left()<cr>" :silent)
(noremap! [n] "<M-j>" "<cmd>lua require('tmux').resize_bottom()<cr>" :silent)
(noremap! [n] "<M-k>" "<cmd>lua require('tmux').resize_top()<cr>" :silent)
(noremap! [n] "<M-l>" "<cmd>lua require('tmux').resize_right()<cr>" :silent)
