(import-macros {: set!} :crux.lib.macro.vim)
(local {: setup
        : mapping} (require :cmp))
(local types (require :cmp.types))

(set! completeopt [:menu :menuone :noselect])

(setup {:preselect types.cmp.PreselectMode.None
        :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
        :mapping {"<C-d>" (mapping.scroll_docs -4)
                  "<C-f>" (mapping.scroll_docs 4)
                  "<C-space>" (mapping.complete)
                  "<C-e>" (mapping.close)
                  "<tab>" (mapping.select_next_item)
                  "<S-tab>" (mapping.select_prev_item)
                  "<space>" (mapping.confirm {:select false})}
        :sources [{:name "nvim_lsp"}
                  {:name "vsnip"}
                  {:name "buffer"}
                  {:name "spell"}]})
