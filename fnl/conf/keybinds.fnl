(import-macros {: noremap!} :conf.macro.keybind)

(fn wildmenumode? [...] (= (vim.fn.wildmenumode ...) 1))

(fn escape [combination]
  (vim.api.nvim_replace_termcodes combination true true true))

;;; ===============
;;; Quickfix window
;;; ===============
;; Open or focus the quickfix window
(noremap! [n] "<localleader>q" "<cmd>copen<cr>"
          "open or focus the quickfix window")
;; Close the quickfix window
(noremap! [n] "<localleader>Q" "<cmd>cclose<cr>"
          "close the quickfix list window")

;;; ========
;;; Wildmenu
;;; ========
;; Close the wildmenu
(noremap! [c] "<space>" (if (wildmenumode?) (escape "<C-y>")
                          (escape "<space>")))

;;; ========
;;; Movement
;;; ========
;; Move to the beginning
(noremap! [nvo] "<C-h>" "^")
(noremap! [nvo] "<C-left>" "^")
(noremap! [i] "<C-h>" "<C-o>^")
(noremap! [i] "<C-left>" "<C-o>^")
(noremap! [c] "<C-h>" "<home>")
(noremap! [c] "<C-left>" "<home>")
;; Move to the end
(noremap! [nvo] "<C-l>" "$")
(noremap! [nvo] "<C-right>" "$")
(noremap! [i] "<C-l>" "<C-o>$")
(noremap! [i] "<C-right>" "<C-o>$")
(noremap! [c] "<C-l>" "<end>")
(noremap! [c] "<C-right>" "<end>")

;;; ============
;;; Text objects
;;; ============
;; Line object
; Inner line
(noremap! [xo :silent] "il" ":<C-u>normal! g_v^<cr>"
          "inner line")
; Around line
(noremap! [xo :silent] "al" ":<C-u>normal! $v0<cr>"
          "around line")
;; Document object
; Inner document
(noremap! [x :silent] "id" ":<C-u>normal! G$Vgg0<cr>"
          "inner document")
(noremap! [o :silent] "id" ":<C-u>normal! GVgg<cr>"
          "inner document")
