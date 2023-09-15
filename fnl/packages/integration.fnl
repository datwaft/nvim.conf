(fn config []
  (local smart-splits (require "smart-splits"))

  ;; Setup
  (smart-splits.setup)

  ;; Mappings
  (map! [n] "<A-h>" smart-splits.resize_left)
  (map! [n] "<A-j>" smart-splits.resize_down)
  (map! [n] "<A-k>" smart-splits.resize_up)
  (map! [n] "<A-l>" smart-splits.resize_right)
  (map! [n] "<C-w>h" smart-splits.move_cursor_left)
  (map! [n] "<C-w>j" smart-splits.move_cursor_down)
  (map! [n] "<C-w>k" smart-splits.move_cursor_up)
  (map! [n] "<C-w>l" smart-splits.move_cursor_right))


[;; TMUX
 (pack "mrjones2014/smart-splits.nvim" {: config})
 ;; Discord
 (pack "andweeb/presence.nvim")
 ;; nfnl
 (pack "Olical/nfnl")
 ]
