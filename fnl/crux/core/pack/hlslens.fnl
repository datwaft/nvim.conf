(import-macros {: noremap!} :crux.lib.macro.vim)

(noremap! [nvo :silent] "n" "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo :silent] "N" "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "*" "*<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "#" "#<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "g*" "g*<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "g#" "g#<cmd>lua require'hlslens'.start()<cr>")
(noremap! [n :silent] "<localleader>l" ":noh<cr>"
          "Clear highlight")
