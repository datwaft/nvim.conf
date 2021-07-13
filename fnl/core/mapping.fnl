(module core.mapping
  {autoload {m vimp
             a aniseed.core}})

; Use <space> to close wildmenu
(m.cnoremap [:override :expr] "<space>"
            "wildmenumode() ? \"\\<C-y>\" : \"\\<space>\"")

; Move to the beginning or end with H or L
(m.nnoremap [:override :silent] "H" "^")
(m.nnoremap [:override :silent] "L" "$")
(m.inoremap [:override :silent] "<C-h>" "<C-o>^")
(m.inoremap [:override :silent] "<C-l>" "<C-o>$")
(m.cnoremap [:override] "<C-h>" "<home>")
(m.cnoremap [:override] "<C-l>" "<end>")

; Use Y to copy from the cursor to the end
(m.nnoremap [:override :silent] "Y" "y$")

; Execute macro fast
(m.xnoremap [:override :silent] "Q" ":normal @@<CR>")
(m.nnoremap [:override :silent] "Q" ":normal @@<CR>")
; Move lines up and down
(m.nnoremap [:override :silent] "<C-k>" ":m-2<CR>")
(m.nnoremap [:override :silent] "<C-up>" ":m-2<CR>")
(m.nnoremap [:override :silent] "<C-j>" ":m+<CR>")
(m.nnoremap [:override :silent] "<C-down>" ":m+<CR>")

;;; ============
;;; Text objects
;;; ============

;; Line object
; Inner line
(m.xnoremap [:override :silent] "il" ":<C-u>normal! g_v^<cr>")
(m.onoremap [:override :silent] "il" ":<C-u>normal! g_v^<cr>")
; Around line
(m.xnoremap [:override :silent] "al" ":<C-u>normal! $v0<cr>")
(m.onoremap [:override :silent] "al" ":<C-u>normal! $v0<cr>")

;; Document object
; Inner document
(m.xnoremap [:override :silent] "id" ":<C-u>normal! G$Vgg0<cr>")
(m.onoremap [:override :silent] "id" ":<C-u>normal! GVgg<cr>")
