(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)
(import-macros {: set!
                : local-set!} :themis.opt)
(import-macros {: buf-map!} :themis.keybind)

(fn bufexists? [...] (= (vim.fn.bufexists ...) 1))

;;; ======
;;; Cursor
;;; ======
;; Restore cursor on exit
(augroup! restore-cursor-on-exit
  (clear!)
  (autocmd! VimLeave * #(set! guicursor ["a:ver100-blinkon0"])))
;; Open file on its last cursor position
(augroup! open-file-on-last-position
  (clear!)
  (autocmd! BufReadPost * #(vim.cmd "silent! normal! g`\"zv")))

;;; ======
;;; Splits
;;; ======
;; Resize splits when window is resized
(augroup! resize-splits-on-resize
  (clear!)
  (autocmd! VimResized * #(vim.cmd.wincmd "=")))

;;; =====
;;; Files
;;; =====
;; Read file when it changes on disk
(augroup! read-file-on-disk-change
  (clear!)
  (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
    #(if (and (not= :c (vim.fn.mode))
              (not (bufexists? "[Command Line]")))
       (vim.cmd.checktime)))
  (autocmd! FileChangedShellPost *
    #(vim.notify "File changed on disk. Buffer reloaded." vim.log.levels.INFO)))

;;; ========
;;; Terminal
;;; ========
(augroup! terminal-options
  (clear!)
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

;;; ===============
;;; Disable 'spell'
;;; ===============
(augroup! disable-spell
  (clear!)
  (autocmd! FileType [checkhealth gitignore help qf man]
    #(local-set! nospell)))

;;; ==============
;;; Disable 'wrap'
;;; ==============
(augroup! disable-wrap
  (clear!)
  (autocmd! FileType [clojure fennel lisp]
    #(local-set! nowrap)))

;;; ===========================
;;; Properly open files with gf
;;; ===========================
(augroup! properly-open-files-with-gf
  (clear!)
  ;; Fennel
  (autocmd! FileType [fennel lua]
    #(do
       (local-set! path^ (.. (vim.fn.stdpath "config") "/lua"))
       (local-set! path^ (.. (vim.fn.stdpath "config") "/fnl"))
       (local-set! suffixesadd^ "/init.fnl")
       (local-set! suffixesadd^ ".fnl")
       (local-set! suffixesadd^ "/init.lua")
       (local-set! suffixesadd^ ".lua")
       (local-set! includeexpr "tr(v:fname,'.','/')"))))

;;; ===============
;;; Set 'formatprg'
;;; ===============
(augroup! set-formatprg
  (clear!)
  ;; Fennel
  (autocmd! FileType [fennel]
    #(local-set! formatprg "fnlfmt - | tail -r | tail -n +2 | tail -r")))

;;; =================
;;; Quickfix mappings
;;; =================
(augroup! quickfix-mappings
  (clear!)
  (autocmd! FileType qf #(buf-map! [n] "<leader>q" "<cmd>cclose<cr>"))
  (autocmd! FileType qf #(buf-map! [n] "dd" #(let [current-item (vim.fn.line ".")
                                                   current-list (vim.fn.getqflist)
                                                   new-list (doto current-list (table.remove current-item))]
                                               (vim.fn.setqflist new-list "r")))))
