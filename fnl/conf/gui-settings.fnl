(import-macros {: set!} :themis.opt)
(import-macros {: let!} :themis.var)
(import-macros {: map!} :themis.keybind)

;;; =============
;;; Configuration
;;; =============
;; Font
(set! guifont ["Victor Mono:h13"])
;; Hide mouse when typing
(let! neovide_hide_mouse_when_typing true)

;;; ========
;;; Keybinds
;;; ========
;; Change scale dynamically
(local delta 1.10)
(let! neovide_scale_factor 1.0)
(map! [invo] "<C-=>" #(let! neovide_scale_factor (* vim.g.neovide_scale_factor delta)))
(map! [invo] "<D-=>" #(let! neovide_scale_factor (* vim.g.neovide_scale_factor delta)))
(map! [invo] "<C-->" #(let! neovide_scale_factor (* vim.g.neovide_scale_factor (/ 1 delta))))
(map! [invo] "<D-->" #(let! neovide_scale_factor (* vim.g.neovide_scale_factor (/ 1 delta))))
;; Paste
(map! [i] "<D-v>" "<C-r>+")
