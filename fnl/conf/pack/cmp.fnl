(import-macros {: set!} :themis.opt)
(local {: setup
        : mapping
        :config {: compare
                 : disable}
        :SelectBehavior {:Insert insert-behavior
                         :Select select-behavior}
        : event} (require :cmp))
(local types (require :cmp.types))
(local under-compare (require :cmp-under-comparator))
(local {: insert} table)

(set! completeopt [:menu :menuone :noselect])

(setup {:preselect types.cmp.PreselectMode.None
        :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
        :mapping {"<C-b>" (mapping.scroll_docs -4)
                  "<C-f>" (mapping.scroll_docs 4)
                  "<C-space>" (mapping.complete)
                  "<C-e>" disable
                  "<up>" disable
                  "<down>" disable
                  "<Tab>" (mapping (mapping.select_next_item {:behavior insert-behavior}) [:i :s])
                  "<S-Tab>" (mapping (mapping.select_prev_item {:behavior insert-behavior}) [:i :s])
                  "<space>" (mapping.confirm {:select false})}
        :sources [{:name "nvim_lsp"}
                  {:name "vsnip"}
                  {:name "path"}
                  {:name "buffer" :option {:keyword_pattern "\\k\\+"}}
                  {:name "tmux"}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}})
