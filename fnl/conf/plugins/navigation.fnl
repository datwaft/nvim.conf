(import-macros {: pack} :themis.pack.lazy)

(fn telescope-config []
  (import-macros {: map!} :themis.keybind)

  (local telescope (require :telescope))
  (local builtin (require :telescope.builtin))
  (local actions (require :telescope.actions))

  ;;; ========
  ;;; Mappings
  ;;; ========
  (map! [n] "<leader>ff" builtin.find_files)
  (map! [n] "<leader>fg" builtin.live_grep)
  (map! [n] "<leader>fb" builtin.buffers)
  (map! [n] "<leader>fh" builtin.help_tags)
  (map! [n] "<leader>fq" builtin.quickfix)
  (map! [n] "<leader>fk" builtin.loclist)

  (local keybinds
    {"<C-h>"    actions.which_key
     "<ESC>"    actions.close
     "<C-q>"    actions.smart_send_to_qflist
     "<C-k>"    actions.smart_send_to_loclist
     "<M-Up>"   actions.cycle_history_prev
     "<M-Down>" actions.cycle_history_next})

  ;;; =============
  ;;; Configuration
  ;;; =============
  (local history-database (.. conf.databases-folder "/telescope_history.sqlite3"))

  (telescope.setup {:defaults {:mappings {:i keybinds}
                               :history {:path history-database
                                         :limit 100}
                               :prompt_prefix "   "
                               :selection_caret "  "
                               :layout_config {:horizontal {:prompt_position "top"
                                                            :preview_width 0.55
                                                            :results_width 0.8}
                                               :vertical {:mirror false}
                                               :width 0.87
                                               :height 0.80
                                               :preview_cutoff 120}
                               :sorting_strategy "ascending"}})

  ;;; ==========
  ;;; Extensions
  ;;; ==========
  (telescope.load_extension "fzf")
  (telescope.load_extension "smart_history"))

[;; Fuzzy-finding
 (pack "nvim-telescope/telescope.nvim"
       {:dependencies ["nvim-lua/plenary.nvim"
                       (pack "nvim-telescope/telescope-fzf-native.nvim"
                             {:build "make"})
                       (pack "nvim-telescope/telescope-smart-history.nvim"
                             {:dependencies "tami5/sqlite.lua"})]
        :config telescope-config})]
