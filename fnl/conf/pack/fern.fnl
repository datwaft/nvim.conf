(import-macros {: map!} :themis.keybind)
(import-macros {: let!} :themis.var)
(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

(local fr-web-icons (require :fr-web-icons))

(map! [n] "<C-n>" "<cmd>Fern . -reveal=% -drawer -toggle<cr>")

(let! fern#renderer :nvim-web-devicons)
(let! glyph_palette#palette (fr-web-icons.palette))

(augroup! add-colors-to-fern-buffer
  (clear!)
  (autocmd! FileType fern '(vim.fn.glyph_palette#apply)))
