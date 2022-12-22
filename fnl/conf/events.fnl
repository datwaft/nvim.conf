(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)
(import-macros {: set!
                : local-set!} :themis.opt)

(local {: line
        : mode} vim.fn)
(fn bufexists? [...] (= (vim.fn.bufexists ...) 1))

;;; ======
;;; Cursor
;;; ======
;; Restore cursor on exit
(augroup! restore-cursor-on-exit
  (clear!)
  (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))
;; Open file on its last cursor position
(augroup! open-file-on-last-position
  (clear!)
  (autocmd! BufReadPost * '(if (and (> (line "'\"") 1)
                                    (<= (line "'\"") (line "$")))
                             (vim.cmd.normal {:args ["g'\""] :bang true}))))

;;; ======
;;; Splits
;;; ======
;; Resize splits when window is resized
(augroup! resize-splits-on-resize
  (clear!)
  (autocmd! VimResized * "wincmd ="))

;;; =====
;;; Files
;;; =====
;; Read file when it changes on disk
(augroup! read-file-on-disk-change
  (clear!)
  (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
            '(if (and (not= :c (mode))
                      (not (bufexists? "[Command Line]")))
               (vim.cmd.checktime)))
  (autocmd! FileChangedShellPost *
            '(vim.notify "File changed on disk. Buffer reloaded." vim.log.levels.INFO)))

;;; ========
;;; Terminal
;;; ========
(augroup! terminal-options
  (clear!)
  ;; Enter Terminal-mode (insert) automatically
  (autocmd! TermOpen * "startinsert")
  ;; Disables line number on terminal buffers
  (autocmd! TermOpen * '(do
                          (local-set! nonumber)
                          (local-set! norelativenumber)))
  ;; Disables spell on terminal buffers
  (autocmd! TermOpen * '(local-set! nospell))
  ;; Disables sign column on terminal buffers
  (autocmd! TermOpen * '(local-set! signcolumn :no))
  ;; Disables colorcolumn on terminal buffers
  (autocmd! TermOpen * '(local-set! colorcolumn [])))
