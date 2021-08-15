(module core.mapping
  {require-macros [core.macros]})

; Use <space> to close wildmenu
(noremap! [c :expr] "<space>" #(if
                                 (= (vim.fn.wildmenumode) 1) (t "<C-y>")
                                 (t "<space>")))

; Move to the beginning or end with H or L
(noremap! [n :silent] "<C-h>" "^")
(noremap! [n :silent] "<C-l>" "$")
(noremap! [i :silent] "<C-h>" "<C-o>^")
(noremap! [i :silent] "<C-l>" "<C-o>$")
(noremap! [c] "<C-h>" "<home>")
(noremap! [c] "<C-l>" "<end>")

; Allow moving the cursor through wrapped lines with j, k, <up> and <down>
(noremap! [nv :silent :expr] "j" #(if (= vim.v.count 0) "gj"
                                    (if (> vim.v.count 5) "m'j" "j")))
(noremap! [nv :silent :expr] "k" #(if (= vim.v.count 0) "gk"
                                    (if (> vim.v.count 5) "m'k" "k")))
(noremap! [nv :silent :expr] "<down>" #(if (= vim.v.count 0) "gj"
                                         (if (> vim.v.count 5) "m'<down>" "<down>")))
(noremap! [i :silent :expr] "<down>" #(if (= vim.v.count 0) (t "<C-o>gj")
                                        (if (> vim.v.count 5) (t "m'<down>") (t "<down>"))))
(noremap! [nv :silent :expr] "<up>" #(if (= vim.v.count 0) "gk"
                                       (if (> vim.v.count 5) "m'<up>" "<up>")))
(noremap! [i :silent :expr] "<up>" #(if (= vim.v.count 0) (t "<C-o>gk")
                                      (if (> vim.v.count 5) (t "m'<up>") (t "<up>"))))

; Use Y to copy from the cursor to the end
(noremap! [n :silent] "Y" "y$")

; Execute macro fast
(noremap! [xn :silent] "Q" ":normal @@<cr>")

; Move lines up and down
(noremap! [n :silent] "<C-k>" ":m-2<CR>")
(noremap! [n :silent] "<C-j>" ":m+<CR>")
(noremap! [n :silent] "<C-up>" ":m-2<CR>")
(noremap! [n :silent] "<C-down>" ":m+<CR>")

;;; ============
;;; Text objects
;;; ============

;; Line object
; Inner line
(noremap! [xo :silent] "il" ":<C-u>normal! g_v^<cr>")
; Around line
(noremap! [xo :silent] "al" ":<C-u>normal! $v0<cr>")

;; Document object
; Inner document
(noremap! [x :silent] "id" ":<C-u>normal! G$Vgg0<cr>")
(noremap! [o :silent] "id" ":<C-u>normal! GVgg<cr>")
