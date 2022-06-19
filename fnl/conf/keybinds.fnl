(import-macros {: map!} :themis.keybind)

(local {: getbufinfo
        : getbufvar} vim.fn)
(local {:cmd cmd!} vim)
(local {: format} string)
(fn wildmenumode? [...] (= (vim.fn.wildmenumode ...) 1))
(fn empty? [xs] (= 0 (length xs)))

;;; =============
;;; Miscellaneous
;;; =============
;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;;; ===============
;;; Quickfix window
;;; ===============
;; Open or focus the quickfix window
(map! [n] "<localleader>q" "<cmd>copen<cr>")
;; Close the quickfix window
(map! [n] "<localleader>Q" "<cmd>cclose<cr>")

;;; ===================
;;; Filesystem Explorer
;;; ===================
(map! [n] "<C-n>"
      ;; This mapping checks if there are buffers with the filesystem explorer filetype
      ;; If there are, every buffer is closed
      ;; If there are not any, a new one is opened using <cmd>Lexplore<cr>
      '(let [explorer-buffers (icollect [_ {: bufnr} (ipairs (getbufinfo))]
                                (let [filetype (getbufvar bufnr "&filetype")]
                                  (if (= :netrw filetype) bufnr)))]
         (if (empty? explorer-buffers) (cmd! "Lexplore")
           (each [_ bufnr (ipairs explorer-buffers)]
             (cmd! (format "bdelete! %s" bufnr))))))

;;; ========
;;; Wildmenu
;;; ========
;; Close the wildmenu
(map! [c] "<space>" '(if (wildmenumode?) "<C-y>" "<space>")
      {:expr true})

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
