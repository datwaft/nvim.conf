(import-macros {: map!} :crux.lib.macro.vim)

(map! [nvo] "<leader>w" "<plug>CamelCaseMotion_w"
      "Go to next CamelCase word")

(map! [nvo] "<leader>b" "<plug>CamelCaseMotion_b"
      "Go to previous CamelCase word")

(map! [nvo] "<leader>e" "<plug>CamelCaseMotion_e"
      "Go to the end of a CamelCase word")

(map! [xo] "i<leader>w" "<plug>CamelCaseMotion_ie"
      "inner CamelCase word")
