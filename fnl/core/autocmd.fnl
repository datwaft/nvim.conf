(import-macros {: augroup!
                : autocmd!
                : bufset!} :core.macro.vim)
(local {: echo!} (require :core.utils.io))
(local {: cmd!} (require :core.utils.vim))

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

; Disable spell in certain filetypes
(augroup! disable-spell-on-filetypes
          (autocmd! FileType [help packer]
                    #(bufset! nospell)))

; Disable colorcolumn in certain filetypes
(augroup! disable-colorcolumn-on-filetypes
          (autocmd! FileType [help packer
                              NvimTree fern
                              fennel clojure lisp
                              json yaml markdown]
                    #(bufset! colorcolumn [])))

; Set terminal options
(augroup! terminal-options
          ; Enter Terminal-mode (insert) automatically
          (autocmd! TermOpen *
                    "startinsert")
          ; Disables line number on terminal buffers
          (autocmd! TermOpen *
                    #(do
                       (bufset! nonumber)
                       (bufset! norelativenumber)))
          ; Disables spell on terminal buffers
          (autocmd! TermOpen *
                    #(bufset! nospell))
          ; Disables sign column on terminal buffers
          (autocmd! TermOpen *
                    #(bufset! signcolumn :no))
          ; Disables colorcolumn on terminal buffers
          (autocmd! TermOpen *
                    #(bufset! colorcolumn [])))

