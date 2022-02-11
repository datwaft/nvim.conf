(import-macros {: map!} :conf.macro.keybind)

(local {: setup} (require :neo-tree))

(map! [n] "<C-n>" "<cmd>NeoTreeReveal<cr>")

(setup {:hijack_netrw_behavior "disabled"
        :filesystem {:follow_current_file true
                     :use_libuv_file_watcher true
                     :window {:mappings {"<C-n>" "close_window"}}}})
