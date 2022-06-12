(import-macros {: map!} :themis.keybind)

(fn jumpable-forwards? [] (= 1 (vim.fn.vsnip#jumpable 1)))
(fn jumpable-backwards? [] (= 1 (vim.fn.vsnip#jumpable -1)))

(map! [i] "<Tab>" '(if (jumpable-forwards?)
                     "<Plug>(vsnip-jump-next)"
                     "<Tab>") :expr)
(map! [i] "<S-Tab>" '(if (jumpable-backwards?)
                       "<Plug>(vsnip-jump-prev)"
                       "<S-Tab>") :expr)

(map! [s] "<Tab>" '(if (jumpable-forwards?)
                     "<Plug>(vsnip-jump-next)"
                     "<Tab>") :expr)
(map! [s] "<S-Tab>" '(if (jumpable-backwards?)
                       "<Plug>(vsnip-jump-prev)"
                       "<S-Tab>") :expr)
