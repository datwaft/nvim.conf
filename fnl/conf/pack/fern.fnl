(import-macros {: map!} :themis.keybind)
(import-macros {: let!} :themis.var)
(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

;; Toggle drawer
(map! [n] "<C-n>" "<cmd>Fern . -reveal=% -drawer -toggle<cr>")

;; Use nerdfont renderer
(let! fern#renderer :nerdfont)

;; Add colors to fern buffer
(augroup! add-colors-to-fern-buffer
  (clear!)
  (autocmd! FileType fern '(vim.fn.glyph_palette#apply)))
