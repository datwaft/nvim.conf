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
(map! [n] "<leader>q" "<cmd>copen<cr>")
;; Close the quickfix window
(map! [n] "<leader>Q" "<cmd>cclose<cr>")

;;; =========
;;; Tab pages
;;; =========
;; Create a new tab page
(map! [n] "<C-t>n" "<cmd>tabnew<cr>")
;; List tabs
(map! [n] "<C-t>s" "<cmd>tabs<cr>")
;; Navigate to the next tab page
(map! [n] "<C-t>]" "<cmd>tabNext<cr>")
;; Navigate to the previous tab page
(map! [n] "<C-t>[" "<cmd>tabprevious<cr>")
;; Kill current tab page
(map! [n] "<C-t>w" "<cmd>tabclose<cr>")
(map! [n] "<C-t>q" "<cmd>tabclose<cr>")

;;; ========
;;; Wildmenu
;;; ========
;; Close the wildmenu
(map! [c] "<space>" #(if (wildmenumode?) "<C-y>" "<space>")
      {:expr true})

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
