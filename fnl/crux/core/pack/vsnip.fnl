(import-macros {: map!
                : t} :crux.lib.macro.vim)

(map! [i] "<Tab>" #(if (= 1 (vim.fn.vsnip#jumpable 1))
                     "<Plug>(vsnip-jump-next)"
                     "<Tab>"))
(map! [i] "<S-Tab>" #(if (= 1 (vim.fn.vsnip#jumpable -1))
                       "<Plug>(vsnip-jump-prev)"
                       "<S-Tab>"))

(map! [s] "<Tab>" #(if (= 1 (vim.fn.vsnip#jumpable 1))
                     (t "<Plug>(vsnip-jump-next)")
                     (t "<Tab>")))
(map! [s] "<S-Tab>" #(if (= 1 (vim.fn.vsnip#jumpable -1))
                       (t "<Plug>(vsnip-jump-prev)")
                       (t "<S-Tab>")))
