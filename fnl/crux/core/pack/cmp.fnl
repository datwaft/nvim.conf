(import-macros {: set!} :crux.lib.macro.vim)
(local {: setup
        : mapping} (require :cmp))

(set! completeopt [:menu :menuone :noselect])

(setup {:snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
        :mapping {"<C-d>" (mapping.scroll_docs -4)
                  "<C-f>" (mapping.scroll_docs 4)
                  "<C-space>" (mapping.complete)
                  "<C-e>" (mapping.close)
                  "<tab>" (mapping.select_next_item)
                  "<S-tab>" (mapping.select_prev_item)
                  "<space>" (mapping.confirm {:select false})}
        :sources [{:name "buffer"}
                  {:name "nvim_lsp"}
                  {:name "vsnip"}]})
