(import-macros {: buf-map!} :conf.macro.keybind)

(buf-map! [n] "<localleader>q" "<cmd>cclose<cr>"
              "close the quickfix list window")
