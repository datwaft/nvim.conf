(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local ufo (require :ufo))

  ;;; =======
  ;;; Options
  ;;; =======
  (import-macros {: set!} :themis.opt)

  (set! foldlevel 99)
  (set! foldlevelstart 99)
  (set! foldenable true)

  ;;; ========
  ;;; Mappings
  ;;; ========
  (import-macros {: map!} :themis.keybind)

  (map! [n] "zR" ufo.openAllFolds)
  (map! [n] "zM" ufo.closeAllFolds)

  (ufo.setup))

(pack "kevinhwang91/nvim-ufo" {:dependencies ["kevinhwang91/promise-async"
                                              "neovim/nvim-lspconfig"
                                              "nvim-treesitter/nvim-treesitter"]
                               : config})
