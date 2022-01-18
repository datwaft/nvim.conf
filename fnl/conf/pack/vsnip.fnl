(import-macros {: map!} :conf.macro.keybind)

(fn escape [combination]
  (vim.api.nvim_replace_termcodes combination true true true))

(fn vsnip#jumpable-forwards? [] (= 1 (vim.fn.vsnip#jumpable 1)))
(fn vsnip#jumpable-backwards? [] (= 1 (vim.fn.vsnip#jumpable -1)))

(map! [i] "<Tab>" (if (vsnip#jumpable-forwards?)
                    (escape "<Plug>(vsnip-jump-next)")
                    (escape "<Tab>")))
(map! [i] "<S-Tab>" (if (vsnip#jumpable-backwards?)
                      (escape "<Plug>(vsnip-jump-prev)")
                      (escape "<S-Tab>")))

(map! [s] "<Tab>" (if (vsnip#jumpable-forwards?)
                    (escape "<Plug>(vsnip-jump-next)")
                    (escape "<Tab>")))
(map! [s] "<S-Tab>" (if (vsnip#jumpable-backwards?)
                      (escape "<Plug>(vsnip-jump-prev)")
                      (escape "<S-Tab>")))
