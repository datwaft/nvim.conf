(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

(local {: expand
        : mkdir} vim.fn)

;;; =========
;;; Constants
;;; =========

(local databases-folder (expand "~/.local/share/nvim/databases"))
(local icons {:error ""
              :warn ""
              :info ""
              :hint ""})
(local lisp-filetypes [:fennel
                       :clojure
                       :lisp
                       :racket
                       :scheme
                       :janet])

(tset _G :conf {: databases-folder
                : icons
                : lisp-filetypes})

;;; =====
;;; Setup
;;; =====

;; Create folders if non-existent
(augroup! create-folders-if-non-existent
  (clear!)
  (autocmd! VimEnter * '(mkdir databases-folder :p)
            {:once true}))
