(import-macros {: noremap!} :conf.macro.keybind)

(noremap! [nvo :silent] "n" "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo :silent] "N" "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "*" "*<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "#" "#<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "g*" "g*<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "g#" "g#<cmd>lua require'hlslens'.start()<cr>")
(noremap! [n] "<leader>l" "<cmd>noh<cr>"
          "Clear highlight")
