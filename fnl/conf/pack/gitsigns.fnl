(import-macros {: map!} :conf.macro.keybind)

(local {: setup} (require :gitsigns))

(fn on-attach [bufnr]
  (local {:stage_buffer stage-buffer!
          :undo_stage_hunk undo-stage-hunk!
          :reset_buffer reset-buffer!
          :preview_hunk preview-hunk!
          :blame_line blame-line!
          :toggle_current_line_blame toggle-current-line-blame!
          :diffthis diff!
          :toggle_deleted toggle-deleted!} package.loaded.gitsigns)

  ;; Navigation
  (map! [n :expr] "]c" (if (vim.opt.diff:get) "]c" "<cmd>Gitsigns next_hunk<cr>"))
  (map! [n :expr] "[c" (if (vim.opt.diff:get) "[c" "<cmd>Gitsigns prev_hunk<cr>"))
  ;; Actions
  (map! [nv] "<leader>hs" "<cmd>Gitsigns stage_hunk<cr>")
  (map! [nv] "<leader>hr" "<cmd>Gitsigns reset_hunk<cr>")
  (map! [n] "<leader>hS" stage-buffer!)
  (map! [n] "<leader>hu" undo-stage-hunk!)
  (map! [n] "<leader>hR" reset-buffer!)
  (map! [n] "<leader>hp" preview-hunk!)
  (map! [n] "<leader>hb" (blame-line! {:full true}))
  (map! [n] "<leader>tb" toggle-current-line-blame!)
  (map! [n] "<leader>hd" diff!)
  (map! [n] "<leader>hD" (diff! "~"))
  (map! [n] "<leader>td" toggle-deleted!)
  ;; Text object
  (map! [ox] "ih" ":<C-U>Gitsigns select_hunk<cr>"))

(setup {:on_attach on-attach})
