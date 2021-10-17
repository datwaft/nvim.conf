(import-macros {: noremap!} :crux.lib.macro.vim)

(local {: setup} (require :dapui))

(setup)

(noremap! [n] "<A-a>" "<cmd>lua require'dapui'.toggle()<cr>")
