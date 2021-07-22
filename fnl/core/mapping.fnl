(module core.mapping
  {require-macros [core.macros]})

; Use <space> to close wildmenu
(noremap! [c] "<space>" #(if
                           (= (vim.fn.wildmenumode) 1) (t "<C-y>")
                           (t "<space>")) :expr)

; Use x as s was originally used
(noremap! [n] "x" "s")

; Move to the beginning or end with H or L
(noremap! [n] "H" "^" :silent)
(noremap! [n] "L" "$" :silent)
(noremap! [i] "<C-h>" "<C-o>^" :silent)
(noremap! [i] "<C-l>" "<C-o>^" :silent)
(noremap! [c] "<C-h>" "<home>")
(noremap! [c] "<C-l>" "<end>")

; Use Y to copy from the cursor to the end
(noremap! [n] "Y" "y$" :silent)

; Execute macro fast
(noremap! [xn] "Q" ":normal @@<cr>" :silent)

; Move lines up and down
(noremap! [n] "<C-k>" ":m-2<CR>" :silent)
(noremap! [n] "<C-j>" ":m+<CR>" :silent)
(noremap! [n] "<C-up>" ":m-2<CR>" :silent)
(noremap! [n] "<C-down>" ":m+<CR>" :silent)

;;; ============
;;; Text objects
;;; ============

;; Line object
; Inner line
(noremap! [xo] "il" ":<C-u>normal! g_v^<cr>" :silent)
; Around line
(noremap! [xo] "al" ":<C-u>normal! $v0<cr>" :silent)

;; Document object
; Inner document
(noremap! [x] "id" ":<C-u>normal! G$Vgg0<cr>" :silent)
(noremap! [o] "id" ":<C-u>normal! GVgg<cr>" :silent)
