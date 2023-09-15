(fn on-attach []
  (local gitsigns (require :gitsigns))

  ;; Navigation keybinds
  (fn navigate-to-hunk [direction]
    (assert (or (= direction :next) (= direction :prev)))
    (if vim.wo.diff (if (= direction :next) "]c" "[c")
      (do (vim.schedule (if (= direction :next) #(gitsigns.next_hunk)
                          #(gitsigns.prev_hunk)))
        "<Ignore>")))
  (map! [n] "]c" #(navigate-to-hunk :next) {:expr true})
  (map! [n] "[c" #(navigate-to-hunk :prev) {:expr true})

  ;; Action keybinds
  (map! [n] "<leader>hs" gitsigns.stage_hunk)
  (map! [n] "<leader>hr" gitsigns.reset_hunk)
  (map! [v] "<leader>hs" #(gitsigns.stage_hunk [(vim.fn.line ".") (vim.fn.line "v")]))
  (map! [v] "<leader>hr" #(gitsigns.reset_hunk [(vim.fn.line ".") (vim.fn.line "v")]))
  (map! [n] "<leader>hS" gitsigns.stage_buffer)
  (map! [n] "<leader>hu" gitsigns.undo_stage_hunk)
  (map! [n] "<leader>hR" gitsigns.reset_buffer)
  (map! [n] "<leader>hp" gitsigns.preview_hunk)
  (map! [n] "<leader>hb" #(gitsigns.blame_line {:full true}))
  (map! [n] "<leader>tb" gitsigns.toggle_current_line_blame)
  (map! [n] "<leader>hd" gitsigns.diffthis)
  (map! [n] "<leader>hD" #(gitsigns.diffthis "~"))
  (map! [n] "<leader>td" gitsigns.toggle_deleted)

  ;; Text objects
  (map! [ox] "ih" ":<C-U>Gitsigns select_hunk<CR>"))

(pack "lewis6991/gitsigns.nvim" {:opts {:on_attach on-attach}})
