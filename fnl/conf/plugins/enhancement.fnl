(import-macros {: pack} :themis.pack.lazy)

(fn wilder-setup []
  (local wilder (require :wilder))
  (wilder.setup {:modes [":" "/" "?"]})
  (wilder.set_option "use_python_remote_plugin" 0)
  (wilder.set_option :pipeline
                     [(wilder.branch (wilder.cmdline_pipeline {:fuzzy 1
                                                               :fuzzy_filter (wilder.lua_fzy_filter)})
                                     (wilder.vim_search_pipeline))])
  (wilder.set_option :renderer
                     (wilder.popupmenu_renderer {:highlighter (wilder.lua_fzy_highlighter)
                                                 :left [" " (wilder.popupmenu_devicons)]
                                                 :right [" " (wilder.popupmenu_scrollbar)]
                                                 :highlights {:accent (wilder.make_hl "WilderAccent" "Pmenu" [{:a 1} {:a 1} {:foreground "#f4468f"}])}})))

[;; Keybind discoverability
 (pack "folke/which-key.nvim" {:config true})
 ;; Create directories when necessary
 "jghauser/mkdir.nvim"
 ;; Sorting
 (pack "sQVe/sort.nvim" {:config true})
 ;; Sync spell files
 "micarmst/vim-spellsync"
 ;; Wildmenu
 (pack "gelguy/wilder.nvim" {:config wilder-setup
                             :dependencies ["romgrk/fzy-lua-native"]
                             :event "CmdlineEnter"})]
