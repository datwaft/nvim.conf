(import-macros {: map!} :conf.macro.keybind)
(import-macros {: command!} :conf.macro.cmd)

(command! NNN "FloatermNew --width=0.8 --height=0.8 nnn")
(map! [n] "<C-n>" "<cmd>FloatermNew --width=0.8 --height=0.8 nnn<cr>")
(map! [n] "<C-t>n" "<cmd>FloatermNew --width=0.8 --height=0.8 nnn<cr>")
(map! [n] "<C-t><C-n>" "<cmd>FloatermNew --width=0.8 --height=0.8 nnn<cr>")

(command! Broot "FloatermNew --width=0.8 --height=0.8 broot")
(map! [n] "<C-b>" "<cmd>FloatermNew --width=0.8 --height=0.8 broot<cr>")
(map! [n] "<C-t>b" "<cmd>FloatermNew --width=0.8 --height=0.8 broot<cr>")
(map! [n] "<C-t><C-b>" "<cmd>FloatermNew --width=0.8 --height=0.8 broot<cr>")

(map! [nt] "<C-t>c" "<cmd>FloatermNew<cr>")
(map! [nt] "<C-t><C-c>" "<cmd>FloatermNew<cr>")

(map! [nt] "<C-t>t" "<cmd>FloatermToggle<cr>")
(map! [nt] "<C-t><C-t>" "<cmd>FloatermToggle<cr>")

(map! [nt] "]t" "<cmd>FloatermNext<cr>")
(map! [nt] "<C-t>]" "<cmd>FloatermNext<cr>")
(map! [nt] "<C-t><C-]>" "<cmd>FloatermNext<cr>")

(map! [nt] "[t" "<cmd>FloatermPrev<cr>")
(map! [nt] "<C-t>[" "<cmd>FloatermPrev<cr>")
(map! [nt] "<C-t><C-[>" "<cmd>FloatermPrev<cr>")
