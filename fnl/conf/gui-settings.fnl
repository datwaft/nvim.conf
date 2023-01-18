(import-macros {: set!} :themis.opt)
(import-macros {: let!} :themis.var)
(import-macros {: map!} :themis.keybind)

;;; =============
;;; Configuration
;;; =============
;; Font
(set! guifont ["Victor Mono:h13"])

;; Set default scale
(let! neovide_scale_factor 1.0)

;;; ========
;;; Keybinds
;;; ========
;; Change scale dynamically
(fn scale-font [delta]
  (let! neovide_scale_factor (* vim.g.neovide_scale_factor delta)))
; Zoom in
(map! [invo] "<C-=>" (partial scale-font 1.1))
(map! [invo] "<D-=>" (partial scale-font 1.1))
; Zoom out
(map! [invo] "<C-->" (partial scale-font 0.9))
(map! [invo] "<D-->" (partial scale-font 0.9))

;; Paste from system clipboard
(map! [i] "<D-v>" "<C-r>+")

;; Imitating MacOS keybinds
(map! [invo] "<D-Left>" "<Home>")
(map! [invo] "<D-Right>" "<End>")
(map! [i] "<D-Backspace>" "<C-u>")
(map! [i] "<M-Backspace>" "<C-w>")
