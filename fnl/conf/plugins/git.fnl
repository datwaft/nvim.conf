(import-macros {: pack} :themis.pack.lazy)

(fn git-signs-on-attach []
  (import-macros {: map!} :themis.keybind)
  (import-macros {: set!} :themis.opt)

  (local gs (require :gitsigns))

  ;; Navigation
  (map! [n] "]c" '(if (set! diff?) "]c"
                    (do (vim.schedule #(gs.next_hunk))
                      "<Ignore>"))
        {:expr true})
  (map! [n] "[c" '(if (set! diff?) "[c"
                    (do (vim.schedule #(gs.prev_hunk))
                      "<Ignore>"))
        {:expr true})
  ;; Actions
  (map! [nv] "<leader>hs" "<cmd>Gitsigns stage_hunk<cr>")
  (map! [nv] "<leader>hr" "<cmd>Gitsigns reset_hunk<cr>")
  (map! [n] "<leader>hS" gs.stage_buffer)
  (map! [n] "<leader>hu" gs.undo_stage_hunk)
  (map! [n] "<leader>hR" gs.reset_buffer)
  (map! [n] "<leader>hp" gs.preview_hunk)
  (map! [n] "<leader>hb" '(gs.blame_line {:full true}))
  (map! [n] "<leader>tb" gs.toggle_current_line_blame)
  (map! [n] "<leader>hd" gs.diffthis)
  (map! [n] "<leader>hD" '(gs.diffthis "~"))
  (map! [n] "<leader>td" gs.toggle_deleted)
  ;; Text object
  (map! [ox] "ih" ":<C-U>Gitsigns select_hunk<cr>"))

[(pack "lewis6991/gitsigns.nvim" {:opts {:on_attach git-signs-on-attach}})
 (pack "lambdalisue/gin.vim" {:dependencies ["vim-denops/denops.vim"]})
 (pack "akinsho/git-conflict.nvim" {:opts {:disable_diagnostics true}})]
