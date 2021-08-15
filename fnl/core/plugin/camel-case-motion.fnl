(module core.plugin.camel-case-motion
  {require-macros [core.macros]})

(map! [nvo :silent] "<leader>w" "<Plug>CamelCaseMotion_w")

(map! [nvo :silent] "<leader>b" "<Plug>CamelCaseMotion_b")

(map! [nvo :silent] "<leader>e" "<Plug>CamelCaseMotion_e")

(map! [xo :silent] "i<leader>w" "<Plug>CamelCaseMotion_ie")
