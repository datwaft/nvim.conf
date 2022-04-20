(import-macros {: augroup!
                : autocmd!} :conf.macro.event)

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

(global conf {: databases-folder
              : icons})

;;; =====
;;; Setup
;;; =====

;; Create folders if non-existent
(augroup! create-folders-if-non-existent
  (autocmd! VimEnter * [:once] (mkdir databases-folder :p)))
