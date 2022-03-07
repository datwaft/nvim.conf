(import-macros {: map!} :conf.macro.keybind)

(fn wildmenumode? [...] (= (vim.fn.wildmenumode ...) 1))

;;; =============
;;; Miscellaneous
;;; =============
;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;;; ===============
;;; Quickfix window
;;; ===============
;; Open or focus the quickfix window
(map! [n] "<localleader>q" "<cmd>copen<cr>"
          "open or focus the quickfix window")
;; Close the quickfix window
(map! [n] "<localleader>Q" "<cmd>cclose<cr>"
          "close the quickfix list window")

;;; =====
;;; NETRW
;;; =====
(map! [n] "<C-n>" "<cmd>Vexplore<cr>")

;;; ========
;;; Wildmenu
;;; ========
;; Close the wildmenu
(map! [c :expr] "<space>" (if (wildmenumode?) "<C-y>" "<space>"))

;;; ========
;;; Movement
;;; ========
;; Move to the beginning
(map! [nvo] "<C-h>" "^")
(map! [nvo] "<C-left>" "^")
(map! [i] "<C-h>" "<C-o>^")
(map! [i] "<C-left>" "<C-o>^")
(map! [c] "<C-h>" "<home>")
(map! [c] "<C-left>" "<home>")
;; Move to the end
(map! [nvo] "<C-l>" "$")
(map! [nvo] "<C-right>" "$")
(map! [i] "<C-l>" "<C-o>$")
(map! [i] "<C-right>" "<C-o>$")
(map! [c] "<C-l>" "<end>")
(map! [c] "<C-right>" "<end>")

;;; ============
;;; Text objects
;;; ============
;; Line object
; Inner line
(map! [xo :silent] "il" ":<C-u>normal! g_v^<cr>"
          "inner line")
; Around line
(map! [xo :silent] "al" ":<C-u>normal! $v0<cr>"
          "around line")
;; Document object
; Inner document
(map! [x :silent] "id" ":<C-u>normal! G$Vgg0<cr>"
          "inner document")
(map! [o :silent] "id" ":<C-u>normal! GVgg<cr>"
          "inner document")
