(fn config []
  (local ufo (require :ufo))

  ;; Options
  (set! foldcolumn "0")
  (set! foldlevel 99)
  (set! foldlevelstart 99)
  (set! foldenable true)

  ;; Mappings
  (map! [n] "zR" ufo.openAllFolds)
  (map! [n] "zM" ufo.closeAllFolds)

  (ufo.setup))

(pack "kevinhwang91/nvim-ufo"
      {:dependencies ["kevinhwang91/promise-async"]
       : config})
