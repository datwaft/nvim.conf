(import-macros {: map!} :conf.macro.keybind)

(fn jumpable-forwards? [] (= 1 (vim.fn.vsnip#jumpable 1)))
(fn jumpable-backwards? [] (= 1 (vim.fn.vsnip#jumpable -1)))

(map! [i :expr] "<Tab>" (if (jumpable-forwards?) "<Plug>(vsnip-jump-next)"
                          "<Tab>"))
(map! [i :expr] "<S-Tab>" (if (jumpable-backwards?) "<Plug>(vsnip-jump-prev)"
                            "<S-Tab>"))

(map! [s :expr] "<Tab>" (if (jumpable-forwards?) "<Plug>(vsnip-jump-next)") "<Tab>")
(map! [s :expr] "<S-Tab>" (if (jumpable-backwards?) "<Plug>(vsnip-jump-prev)") "<S-Tab>")
