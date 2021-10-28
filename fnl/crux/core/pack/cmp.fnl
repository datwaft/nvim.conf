(import-macros {: set!} :crux.lib.macro.vim)
(local {: setup
        : mapping
        : config
        :SelectBehavior {:Insert insert-behavior
                         :Select select-behavior}} (require :cmp))
(local types (require :cmp.types))

(set! completeopt [:menu :menuone :noselect])

(setup {:preselect types.cmp.PreselectMode.None
        :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
        :mapping {"<C-d>" (mapping (mapping.scroll_docs -4) [:i :c])
                  "<C-f>" (mapping (mapping.scroll_docs 4) [:i :c])
                  "<C-space>" (mapping (mapping.complete) [:i :c])
                  "<C-e>" (mapping {:i (mapping.abort)
                                    :c (mapping.close)})
                  "<Tab>" (mapping (mapping.select_next_item {:behavior select-behavior}) [:i :s])
                  "<S-Tab>" (mapping (mapping.select_prev_item {:behavior select-behavior}) [:i :s])
                  "<space>" (mapping.confirm {:select false})}
        :sources [{:name "nvim_lsp"}
                  {:name "vsnip"}
                  {:name "path"}
                  {:name "buffer"}
                  {:name "cmdline"}
                  {:name "spell"}]})
