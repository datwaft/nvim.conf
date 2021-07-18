(module core.plugin.hlslens
  {require-macros [core.macros]})

(noremap! [nvo] "n" "<cmd>execute('normal! ' . v:count1 . 'n')<cr>
                     <cmd>lua require'hlslens'.start()<cr>" :silent)
(noremap! [nvo] "N" "<cmd>execute('normal! ' . v:count1 . 'N')<cr>
                     <cmd>lua require'hlslens'.start()<cr>" :silent)
(noremap! [nvo] "*" "*<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "#" "#<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "g*" "g*<cmd>lua require'hlslens'.start()<cr>")
(noremap! [nvo] "g#" "g#<cmd>lua require'hlslens'.start()<cr>")
(noremap! [n] "<leader>l" ":noh<cr>" :silent)
