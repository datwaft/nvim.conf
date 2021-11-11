(import-macros {: noremap!
                : t} :crux.lib.macro.vim)

(noremap! [nv :silent] "<leader>p" ":PP<cr>")

;; Open or focus the quickfix list window
(noremap! [n] "<localleader>q" "<cmd>copen<cr>"
          "Open or focus the quickfix list window")
;; Close the quickfix list window
(noremap! [n] "<localleader>Q" "<cmd>cclose<cr>"
          "Close the quickfix list window")

;; Use <space> to close wildmenu
(noremap! [c] "<space>" #(if (= (vim.fn.wildmenumode) 1)
                           (t "<C-y>")
                           (t "<space>")))

;; Move to the beginning or end with H or L
(noremap! [nvo] "<C-h>" "^")
(noremap! [nvo] "<C-l>" "$")
(noremap! [i] "<C-h>" "<C-o>^")
(noremap! [i] "<C-l>" "<C-o>$")
(noremap! [c] "<C-h>" "<home>")
(noremap! [c] "<C-l>" "<end>")

;; Execute macro fast
(noremap! [xn] "Q" "<cmd>normal @@<cr>")

;; Move lines up and down
(noremap! [n] "<C-k>" "<cmd>m-2<cr>")
(noremap! [n] "<C-j>" "<cmd>m+<cr>")
(noremap! [n] "<C-up>" "<cmd>m-2<cr>")
(noremap! [n] "<C-down>" "<cmd>m+<cr>")

;;; Text objects

;; Line object
; Inner line
(noremap! [xo :silent] "il" ":<C-u>normal! g_v^<cr>"
          "inner line")
; Around line
(noremap! [xo :silent] "al" ":<C-u>normal! $v0<cr>"
          "at line")

;; Document object
; Inner document
(noremap! [x :silent] "id" ":<C-u>normal! G$Vgg0<cr>"
          "inner document")
(noremap! [o :silent] "id" ":<C-u>normal! GVgg<cr>"
          "inner document")
