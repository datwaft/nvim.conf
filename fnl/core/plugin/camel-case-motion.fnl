(module core.plugin.camel-case-motion
  {autoload {a aniseed.core
             m vimp}})

(m.nmap [:override :silent] "<leader>w" "<Plug>CamelCaseMotion_w")
(m.vmap [:override :silent] "<leader>w" "<Plug>CamelCaseMotion_w")
(m.omap [:override :silent] "<leader>w" "<Plug>CamelCaseMotion_w")

(m.nmap [:override :silent] "<leader>b" "<Plug>CamelCaseMotion_b")
(m.vmap [:override :silent] "<leader>b" "<Plug>CamelCaseMotion_b")
(m.omap [:override :silent] "<leader>b" "<Plug>CamelCaseMotion_b")

(m.nmap [:override :silent] "<leader>e" "<Plug>CamelCaseMotion_e")
(m.vmap [:override :silent] "<leader>e" "<Plug>CamelCaseMotion_e")
(m.omap [:override :silent] "<leader>e" "<Plug>CamelCaseMotion_e")

(m.xmap [:override :silent] "i<leader>w" "<Plug>CamelCaseMotion_ie")
(m.omap [:override :silent] "i<leader>w" "<Plug>CamelCaseMotion_ie")
