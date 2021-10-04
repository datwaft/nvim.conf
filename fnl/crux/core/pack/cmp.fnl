(import-macros {: set!} :crux.lib.macro.vim)
(local {: setup
        : mapping} (require :cmp))

(set! completeopt [:menu :menuone :noselect])

(setup {:mapping {"<C-d>" (mapping.scroll_docs -4)
                  "<C-f>" (mapping.scroll_docs 4)
                  "<C-Space>" (mapping.complete)
                  "<C-e>" (mapping.close)
                  "<Tab>" (mapping.select_next_item)
                  "<S-Tab>" (mapping.select_prev_item)
                  "<Space>" (mapping.confirm {:select true})}
        :sources [{:name "buffer"}
                  {:name "nvim_lsp"}]})
