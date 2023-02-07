(import-macros {: map!} :themis.keybind)

(fn wildmenumode? [...] (= (vim.fn.wildmenumode ...) 1))

;;; =============
;;; Miscellaneous
;;; =============
;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")
;; Make `/` and `?` search inside selection
(map! [x] "/" "<esc>/\\%V")
(map! [x] "?" "<esc>?\\%V")

;;; ===============
;;; Quickfix window
;;; ===============
;; Open or focus the quickfix window
(map! [n] "<localleader>q" "<cmd>copen<cr>")
;; Close the quickfix window
(map! [n] "<localleader>Q" "<cmd>cclose<cr>")

;;; =========
;;; Tab pages
;;; =========
;; Create a new tab page
(map! [n] "<C-t>c" "<cmd>tabnew<cr>")
;; List tabs
(map! [n] "<C-t>w" "<cmd>tabs<cr>")
;; Navigate to the next tab page
(map! [n] "<C-t>n" "<cmd>tabNext<cr>")
;; Navigate to the previous tab page
(map! [n] "<C-t>p" "<cmd>tabprevious<cr>")
;; Kill current tab page
(map! [n] "<C-t>&" "<cmd>tabclose<cr>")

;;; ========
;;; Wildmenu
;;; ========
;; Close the wildmenu
(map! [c] "<space>" #(if (wildmenumode?) "<C-y>" "<space>")
      {:expr true})

;;; ========
;;; Movement
;;; ========
;; Move words with <A-Right> and <A-Left>
(map! [nvo] "<A-Left>" "b")
(map! [nvo] "<A-Right>" "e")
(map! [i] "<A-Left>" "<C-o>b")
(map! [i] "<A-Right>" "<C-o>e<Right>")
(map! [c] "<A-Left>" "<S-Left>")
(map! [c] "<A-Right>" "<S-Right>")
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
(map! [xo] "il" ":<C-u>normal! g_v^<cr>"
      {:silent true})
; Around line
(map! [xo] "al" ":<C-u>normal! $v0<cr>"
      {:silent true})
;; Document object
; Inner document
(map! [x] "id" ":<C-u>normal! G$Vgg0<cr>"
      {:silent true})
(map! [o] "id" ":<C-u>normal! GVgg<cr>"
      {:silent true})
