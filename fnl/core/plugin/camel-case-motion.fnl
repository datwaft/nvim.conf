(module core.plugin.camel-case-motion
  {require-macros [core.macros]})

(map! [nvo] "<leader>w" "<Plug>CamelCaseMotion_w" :silent)

(map! [nvo] "<leader>b" "<Plug>CamelCaseMotion_b" :silent)

(map! [nvo] "<leader>e" "<Plug>CamelCaseMotion_e" :silent)

(map! [xo] "i<leader>w" "<Plug>CamelCaseMotion_ie" :silent)
