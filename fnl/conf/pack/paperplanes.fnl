(import-macros {: map!} :themis.keybind)

(local {: setup} (require :paperplanes))

(setup {:register "+"
        :provider "0x0.st"})

(map! [nv] "<leader>p" "<cmd>PP<cr>")
