(import-macros {: map!} :themis.keybind)

(local {: setup} (require :tmux))

(setup {:copy_sync {:enable false}
        :navigation {:enable_default_keybindings false}
        :resize {:enable_default_keybindings false}})

(map! [n] "<C-w>h" "<cmd>lua require('tmux').move_left()<cr>")
(map! [n] "<C-w>j" "<cmd>lua require('tmux').move_bottom()<cr>")
(map! [n] "<C-w>k" "<cmd>lua require('tmux').move_top()<cr>")
(map! [n] "<C-w>l" "<cmd>lua require('tmux').move_right()<cr>")

(map! [n] "<M-h>" "<cmd>lua require('tmux').resize_left()<cr>")
(map! [n] "<M-j>" "<cmd>lua require('tmux').resize_bottom()<cr>")
(map! [n] "<M-k>" "<cmd>lua require('tmux').resize_top()<cr>")
(map! [n] "<M-l>" "<cmd>lua require('tmux').resize_right()<cr>")
