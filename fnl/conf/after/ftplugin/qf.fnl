(import-macros {: buf-noremap!} :conf.macro.keybind)

(buf-noremap! [n] "<localleader>q" "<cmd>cclose<cr>"
              "close the quickfix list window")
