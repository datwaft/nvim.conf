(import-macros {: set!} :themis.opt)

(local cmp (require :cmp))
(local under-compare (require :cmp-under-comparator))

(set! completeopt [:menu :menuone :noselect])

(cmp.setup {:preselect cmp.PreselectMode.None
            :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
            :mapping {"<C-b>" (cmp.mapping.scroll_docs -4)
                      "<C-f>" (cmp.mapping.scroll_docs 4)
                      "<C-space>" (cmp.mapping.complete)
                      "<C-e>" cmp.config.disable
                      "<up>" cmp.config.disable
                      "<down>" cmp.config.disable
                      "<Tab>" (cmp.mapping (cmp.mapping.select_next_item
                                             {:behavior cmp.SelectBehavior.Insert})
                                           [:i :s])
                      "<S-Tab>" (cmp.mapping (cmp.mapping.select_prev_item
                                               {:behavior cmp.SelectBehavior.Insert})
                                             [:i :s])
                      "<space>" (cmp.mapping.confirm {:select false})}
            :sources [{:name "nvim_lsp"}
                      {:name "vsnip"}
                      {:name "path"}
                      {:name "buffer" :option {:keyword_pattern "\\k\\+"}}
                      {:name "tmux"}]
            :sorting {:comparators [cmp.config.compare.offset
                                    cmp.config.compare.exact
                                    cmp.config.compare.score
                                    under-compare.under
                                    cmp.config.compare.kind
                                    cmp.config.compare.sort_text
                                    cmp.config.compare.length
                                    cmp.config.compare.order]}})
