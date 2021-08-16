(module core.plugin.camel-case-motion
  {require-macros [core.macros]})

(map! [nvo] "<leader>w" "<plug>CamelCaseMotion_w")

(map! [nvo] "<leader>b" "<plug>CamelCaseMotion_b")

(map! [nvo] "<leader>e" "<plug>CamelCaseMotion_e")

(map! [xo] "i<leader>w" "<plug>CamelCaseMotion_ie")
