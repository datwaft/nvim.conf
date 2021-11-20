(import-macros {: set!} :crux.lib.macro.vim)
(local {: setup
        : mapping
        :config {: compare}
        :SelectBehavior {:Insert insert-behavior
                         :Select select-behavior}} (require :cmp))
(local types (require :cmp.types))
(local under-compare (require :cmp-under-comparator))

(set! completeopt [:menu :menuone :noselect])

(setup {:preselect types.cmp.PreselectMode.None
        :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
        :mapping {"<C-d>" (mapping.scroll_docs -4)
                  "<C-f>" (mapping.scroll_docs 4)
                  "<C-space>" (mapping.complete)
                  "<C-e>" (mapping.abort)
                  "<Tab>" (mapping (mapping.select_next_item {:behavior insert-behavior}) [:i :s])
                  "<S-Tab>" (mapping (mapping.select_prev_item {:behavior insert-behavior}) [:i :s])
                  "<space>" (mapping.confirm {:select false})}
        :sources [{:name "nvim_lsp"}
                  {:name "vsnip"}
                  {:name "path"}
                  {:name "tmux"}
                  {:name "buffer"}
                  {:name "cmdline"}
                  {:name "spell"}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}})
