(import-macros {: set!} :conf.macro.opt)
(local {: setup
        : mapping
        :config {: compare}
        :SelectBehavior {:Insert insert-behavior
                         :Select select-behavior}
        : event} (require :cmp))
(local types (require :cmp.types))
(local under-compare (require :cmp-under-comparator))
(local autopairs (require :nvim-autopairs.completion.cmp))
(local {: insert} table)

(set! completeopt [:menu :menuone :noselect])

(event:on :confirm_done (autopairs.on_confirm_done {:map_char {:tex ""}}))
(insert autopairs.lisp "racket")

(setup {:preselect types.cmp.PreselectMode.None
        :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
        :mapping {"<C-b>" (mapping.scroll_docs -4)
                  "<C-f>" (mapping.scroll_docs 4)
                  "<C-space>" (mapping.complete)
                  "<C-e>" (mapping.abort)
                  "<Tab>" (mapping (mapping.select_next_item {:behavior insert-behavior}) [:i :s])
                  "<S-Tab>" (mapping (mapping.select_prev_item {:behavior insert-behavior}) [:i :s])
                  "<space>" (mapping.confirm {:select false})}
        :sources [{:name "nvim_lsp"}
                  {:name "vsnip"}
                  {:name "path"}
                  {:name "buffer"}
                  {:name "tmux"}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}})
