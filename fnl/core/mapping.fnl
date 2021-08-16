(module core.mapping
  {require-macros [core.macros]})

; Use <space> to close wildmenu
(noremap! [c] "<space>" #(if
                           (= (vim.fn.wildmenumode) 1) (t "<C-y>")
                           (t "<space>")))

; Move to the beginning or end with H or L
(noremap! [n] "<C-h>" "^")
(noremap! [n] "<C-l>" "$")
(noremap! [i] "<C-h>" "<C-o>^")
(noremap! [i] "<C-l>" "<C-o>$")
(noremap! [c] "<C-h>" "<home>")
(noremap! [c] "<C-l>" "<end>")

; Allow moving the cursor through wrapped lines with j, k, <up> and <down>
(noremap! [nv] "j" #(if (= vim.v.count 0) "gj"
                      (if (> vim.v.count 5) "m'j" "j")))
(noremap! [nv] "k" #(if (= vim.v.count 0) "gk"
                      (if (> vim.v.count 5) "m'k" "k")))
(noremap! [nv] "<down>" #(if (= vim.v.count 0) "gj"
                           (if (> vim.v.count 5) "m'<down>" "<down>")))
(noremap! [i] "<down>" #(if (= vim.v.count 0) (t "<C-o>gj")
                          (if (> vim.v.count 5) (t "m'<down>") (t "<down>"))))
(noremap! [nv] "<up>" #(if (= vim.v.count 0) "gk"
                         (if (> vim.v.count 5) "m'<up>" "<up>")))
(noremap! [i] "<up>" #(if (= vim.v.count 0) (t "<C-o>gk")
                        (if (> vim.v.count 5) (t "m'<up>") (t "<up>"))))

; Use Y to copy from the cursor to the end
(noremap! [n] "Y" "y$")

; Execute macro fast
(noremap! [xn] "Q" "<cmd>normal @@<cr>")

; Move lines up and down
(noremap! [n] "<C-k>" "<cmd>m-2<cr>")
(noremap! [n] "<C-j>" "<cmd>m+<cr>")
(noremap! [n] "<C-up>" "<cmd>m-2<cr>")
(noremap! [n] "<C-down>" "<cmd>m+<cr>")

;;; ============
;;; Text objects
;;; ============

;; Line object
; Inner line
(noremap! [xo] "il" "<cmd>normal! g_v^<cr>")
; Around line
(noremap! [xo] "al" "<cmd>normal! $v0<cr>")

;; Document object
; Inner document
(noremap! [x] "id" "<cmd>normal! G$Vgg0<cr>")
(noremap! [o] "id" "<cmd>normal! GVgg<cr>")
