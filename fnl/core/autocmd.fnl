(module core.autocmd
  {autoload {nvim aniseed.nvim
             a aniseed.core
             s aniseed.string}
   require-macros [core.macros]})

(tset _G :__autocmd_id 0)

(defn- process-command [command]
  (if (a.string? command)
    command
    (let [name (a.str "__autocmd_"
                      (do
                        (tset _G :__autocmd_id (a.inc _G.__autocmd_id))
                        _G.__autocmd_id))]
      (tset _G name command)
      (.. "call v:lua." name "()"))))

(defn autocmd [events pattern command]
  (let [events (if (a.table? events) events [events])
        pattern (if (a.table? pattern) pattern [pattern])]
    (let [events (s.join "," events)
          pattern (s.join "," pattern)]
      (nvim.ex.autocmd events pattern (process-command command)))))

; Restore cursor on exit
(augroup restore-cursor-on-exit
         (autocmd :VimLeave "*"
                  "set guicursor=a:ver100-blinkon0"))

; Automatically resize splits when window is resized
(augroup resize-splits-on-resize
         (autocmd :VimResized "*"
                  "wincmd ="))

; Automatically read file when it changes on disk
(augroup read-file-on-disk-change
         (autocmd [:FocusGained :BufEnter :CursorHold :CursorHoldI] "*"
                  #(if (and
                         (~= (vim.fn.mode) "c")
                         (= (vim.fn.bufexists "[Command Line]") 0))
                     (vim.cmd "checktime")))
         (autocmd :FileChangedShellPost "*"
                  "echom \"File changed on disk. Buffer reloaded.\""))

; Open file on last position
(augroup open-file-on-last-position
         (autocmd :BufReadPost "*"
                  #(if (and
                         (> (vim.fn.line "'\"") 1)
                         (<= (vim.fn.line "'\"") (vim.fn.line "$")))
                     (vim.cmd "normal! g'\""))))

; Disable spell in certain filetypes
(augroup disable-spell-on-filetypes
         (autocmd :FileType [:help :packer]
                  "setlocal nospell"))

; Set terminal options
(augroup terminal-options
         ; Enter Terminal-mode (insert) automatically
         (autocmd :TermOpen "*"
                  "startinsert")
         ; Disables line number on terminal buffers
         (autocmd :TermOpen "*"
                  "setlocal nonumber norelativenumber")
         ; Disables spell on terminal buffers
         (autocmd :TermOpen "*"
                  "setlocal nospell")
         ; Disables sign column on terminal buffers
         (autocmd :TermOpen "*"
                  "setlocal signcolumn=\"no\""))
