(import-macros {: set!} :themis.opt)

(local cmp (require :cmp))
(local under-compare (require :cmp-under-comparator))
(local luasnip (require :luasnip))

(set! completeopt [:menu :menuone :noselect])

(cmp.setup {:formatting {:fields [:kind :abbr]
                         :format (fn [entry item]
                                   ; Define kind icons
                                   (set item.kind (or (. conf.kind-icons item.kind) ""))
                                   ; Menu
                                   (set item.menu (or (. conf.source-labels entry.source.name) ""))
                                   item)}
            :window {:completion {:border conf.borders
                                  :winhighlight (table.concat
                                                  (icollect [k v (pairs {:Normal :NormalFloat
                                                                         :FloatBorder :FloatBorder
                                                                         :Search :None})]
                                                    (.. k ":" v)) ",")}
                     :documentation {:border conf.borders}
                                  :winhighlight (table.concat
                                                  (icollect [k v (pairs {:Normal :NormalFloat
                                                                         :FloatBorder :FloatBorder
                                                                         :Search :None})]
                                                    (.. k ":" v)) ",")}
            :preselect cmp.PreselectMode.None
            :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
            :mapping {"<C-b>" (cmp.mapping.scroll_docs -4)
                      "<C-f>" (cmp.mapping.scroll_docs 4)
                      "<C-space>" (cmp.mapping.complete)
                      "<C-e>" (cmp.mapping.close)
                      "<up>" cmp.config.disable
                      "<down>" cmp.config.disable
                      "<Tab>" (cmp.mapping
                                (fn [fallback]
                                  (if (cmp.visible) (cmp.select_next_item)
                                    (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                                    (fallback)))
                                [:i :s])
                      "<S-Tab>" (cmp.mapping
                                  (fn [fallback]
                                    (if (cmp.visible) (cmp.select_prev_item)
                                      (luasnip.jumpable -1) (luasnip.jump -1)
                                      (fallback)))
                                  [:i :s])
                      "<space>" (cmp.mapping.confirm {:select false})}
            :sources [{:name "nvim_lsp"}
                      {:name "luasnip"}
                      {:name "path"}
                      {:name "buffer" :option {:keyword_pattern "\\k\\+"}}
                      {:name "spell"}
                      {:name "tmux"}]
            :sorting {:comparators [cmp.config.compare.offset
                                    cmp.config.compare.exact
                                    cmp.config.compare.score
                                    under-compare.under
                                    cmp.config.compare.kind
                                    cmp.config.compare.sort_text
                                    cmp.config.compare.length
                                    cmp.config.compare.order]}})
