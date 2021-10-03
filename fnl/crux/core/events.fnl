(import-macros {: augroup!
                : autocmd!
                : buf-set!
                : set!} :crux.lib.macro.vim)
(local {: echo!} (require :crux.lib.io))
(local {: cmd!} (require :crux.lib.vim))

; Restore cursor on exit
(augroup! restore-cursor-on-exit
         (autocmd! VimLeave *
                   #(set! guicursor ["a:ver100-blinkon0"])))

; Automatically resize splits when window is resized
(augroup! resize-splits-on-resize
          (autocmd! VimResized *
                    "wincmd ="))

; Automatically read file when it changes on disk
(augroup! read-file-on-disk-change
          (autocmd! [FocusGained BufEnter CursorHold CursorHoldI] *
                    #(if (and
                           (not= (vim.fn.mode) "c")
                           (= (vim.fn.bufexists "[Command Line]") 0))
                       (cmd! "checktime")))
          (autocmd! FileChangedShellPost *
                    #(echo! "File changed on disk. Buffer reloaded.")))

; Open file on last position
(augroup! open-file-on-last-position
          (autocmd! BufReadPost *
                    #(if (and
                           (> (vim.fn.line "'\"") 1)
                           (<= (vim.fn.line "'\"") (vim.fn.line "$")))
                       (cmd! "normal! g'\""))))

; Disable spell in certain filetypes
(augroup! disable-spell-on-filetypes
          (autocmd! FileType [help packer]
                    #(buf-set! nospell)))

; Disable colorcolumn in certain filetypes
(augroup! disable-colorcolumn-on-filetypes
          (autocmd! FileType [help packer
                              NvimTree fern
                              fennel clojure lisp
                              json yaml markdown]
                    #(buf-set! colorcolumn [])))

; Disable wrap in certain filetypes
(augroup! disable-wrap-on-filetypes
          (autocmd! FileType [fennel clojure lisp]
                    #(buf-set! nowrap)))

; Set terminal options
(augroup! terminal-options
          ; Enter Terminal-mode (insert) automatically
          (autocmd! TermOpen *
                    "startinsert")
          ; Disables line number on terminal buffers
          (autocmd! TermOpen *
                    #(do
                       (buf-set! nonumber)
                       (buf-set! norelativenumber)))
          ; Disables spell on terminal buffers
          (autocmd! TermOpen *
                    #(buf-set! nospell))
          ; Disables sign column on terminal buffers
          (autocmd! TermOpen *
                    #(buf-set! signcolumn :no))
          ; Disables colorcolumn on terminal buffers
          (autocmd! TermOpen *
                    #(buf-set! colorcolumn [])))
