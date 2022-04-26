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

(tset _G :conf {: databases-folder
                : icons})

;;; =====
;;; Setup
;;; =====

;; Create folders if non-existent
(augroup! create-folders-if-non-existent
  (autocmd! VimEnter * [:once] (mkdir databases-folder :p)))

;;; =========
;;; Utilities
;;; =========

(fn rerequire [module-name]
  "Require the module ignoring the cache."
  (tset package.loaded module-name nil)
  (require module-name))

(tset _G :rerequire rerequire)
