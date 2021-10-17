(import-macros {: noremap!} :crux.lib.macro.vim)

(local {: setup
        : toggle} (require :dapui))

(setup)

(noremap! [n] "<localleader>S" #(do (toggle) ""))
