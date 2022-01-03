(import-macros {: augroup!
                : autocmd!} :conf.macro.event)
(import-macros {: set!
                : local-set!} :conf.macro.opt)

(local {: echo!} (require :conf.lib.io))
(local {: line
        : mode} vim.fn)
(fn cmd! [...] (vim.cmd ...))
(fn bufexists? [...] (= (vim.fn.bufexists ...) 1))

;;; ======
;;; Cursor
;;; ======
;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * #(set! guicursor ["a:ver100-blinkon0"])))
;; Open file on its last cursor position
(augroup! open-file-on-last-position
          (autocmd! BufReadPost * #(if (and (> (line "'\"") 1)
                                            (<= (line "'\"") (line "$")))
                                     (cmd! "normal! g'\""))))

;;; ======
;;; Splits
;;; ======
;; Resize splits when window is resized
(augroup! resize-splits-on-resize
          (autocmd! VimResized * "wincmd ="))

;;; =====
;;; Files
;;; =====
;; Read file when it changes on disk
(augroup! read-file-on-disk-change
          (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
                    #(if (and (not= :c (mode))
                              (not (bufexists? "[Command Line]")))
                       (cmd! "checktime")))
          (autocmd! FileChangedShellPost *
                    #(echo! "File changed on disk. Buffer reloaded.")))

;;; ========
;;; Terminal
;;; ========
(augroup! terminal-options
          ;; Enter Terminal-mode (insert) automatically
          (autocmd! TermOpen * "startinsert")
          ;; Disables line number on terminal buffers
          (autocmd! TermOpen * #(do
                                  (local-set! nonumber)
                                  (local-set! norelativenumber)))
          ;; Disables spell on terminal buffers
          (autocmd! TermOpen * #(local-set! nospell))
          ;; Disables sign column on terminal buffers
          (autocmd! TermOpen * #(local-set! signcolumn :no))
          ;; Disables colorcolumn on terminal buffers
          (autocmd! TermOpen * #(local-set! colorcolumn [])))
