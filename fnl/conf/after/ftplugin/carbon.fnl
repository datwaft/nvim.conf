(import-macros {: local-set!} :conf.macro.opt)
(import-macros {: buf-map!} :conf.macro.keybind)

(local-set! nospell)

(buf-map! [n] "<C-n>" "<cmd>quit<cr>")
