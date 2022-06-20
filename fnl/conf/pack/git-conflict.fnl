(import-macros {: map!} :themis.keybind)

(local {: setup} (require :git-conflict))

(setup {:disable_diagnostics true})

(map! [n] "<leader>lc" "<cmd>GitConflictListQf<cr>"
      {:silent true})
