(import-macros {: noremap!} :conf.macro.keybind)

(local {: setup} (require :paperplanes))

(setup {:register "+"
        :provider "0x0.st"})

(noremap! [nv] "<leader>p" "<cmd>PP<cr>")
