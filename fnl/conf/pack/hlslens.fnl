(import-macros {: map!} :themis.keybind)

(map! [nvo] "n" "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require'hlslens'.start()<cr>"
      :silent)
(map! [nvo] "N" "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require'hlslens'.start()<cr>"
      :silent)
(map! [nvo] "*" "*<cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] "#" "#<cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] "g*" "g*<cmd>lua require'hlslens'.start()<cr>")
(map! [nvo] "g#" "g#<cmd>lua require'hlslens'.start()<cr>")
