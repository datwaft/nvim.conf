(import-macros {: map!} :themis.keybind)

(map! [nvo] "<leader>w" "<Plug>CamelCaseMotion_w"
      "Go to next CamelCase word")

(map! [nvo] "<leader>b" "<Plug>CamelCaseMotion_b"
      "Go to previous CamelCase word")

(map! [nvo] "<leader>e" "<Plug>CamelCaseMotion_e"
      "Go to the end of a CamelCase word")

(map! [xo] "i<leader>w" "<Plug>CamelCaseMotion_ie"
      "inner CamelCase word")

