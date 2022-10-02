(import-macros {: map!} :themis.keybind)

;; Toggle drawer
(map! [n] "<C-n>" "<cmd>Fern . -reveal=% -drawer -toggle<cr>")
