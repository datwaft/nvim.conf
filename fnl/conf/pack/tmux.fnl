(import-macros {: noremap!} :conf.macro.keybind)

(local {: setup} (require :tmux))

(setup {:copy_sync {:enable true
                    :sync_clipboard false}
        :navigation {:enable_default_keybindings false}
        :resize {:enable_default_keybindings false}})

(noremap! [n] "<C-w>h" "<cmd>lua require('tmux').move_left()<cr>")
(noremap! [n] "<C-w>j" "<cmd>lua require('tmux').move_bottom()<cr>")
(noremap! [n] "<C-w>k" "<cmd>lua require('tmux').move_top()<cr>")
(noremap! [n] "<C-w>l" "<cmd>lua require('tmux').move_right()<cr>")

(noremap! [n] "<M-h>" "<cmd>lua require('tmux').resize_left()<cr>")
(noremap! [n] "<M-j>" "<cmd>lua require('tmux').resize_bottom()<cr>")
(noremap! [n] "<M-k>" "<cmd>lua require('tmux').resize_top()<cr>")
(noremap! [n] "<M-l>" "<cmd>lua require('tmux').resize_right()<cr>")
