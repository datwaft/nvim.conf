(import-macros {: set!} :themis.opt)

(local cmp (require :cmp))
(local under-compare (require :cmp-under-comparator))
(local cmp-buffer (require :cmp_buffer))

(fn feedkey [key mode]
  (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes key true true true) mode true))

(set! completeopt [:menu :menuone :noselect])

(fn format-item [entry item]
  ; Define kind icons
  (set item.kind (or (. conf.kind-icons item.kind) ""))
  ; Define menu labels
  (set item.menu (or (. conf.source-labels entry.source.name) ""))
  ; Return the item
  item)

(local group->highlight
  {:Normal      :NormalFloat
   :FloatBorder :FloatBorder
   :Search      :None})

(local highlight
  (table.concat
    (icollect [k v (pairs group->highlight)]
      (.. k ":" v))
    ","))

(local mappings
  {"<C-b>"     (cmp.mapping.scroll_docs -4)
   "<C-f>"     (cmp.mapping.scroll_docs 4)
   "<C-Space>" (cmp.mapping.complete)
   "<C-e>"     (cmp.mapping.abort)
   "<Space>"   (cmp.mapping.confirm {:select false})
   "<CR>"      (cmp.mapping.confirm {:select true})
   "<Tab>"     (cmp.mapping (fn [fallback]
                              (if (cmp.visible) (cmp.select_next_item)
                                (= (vim.fn.vsnip#available 1) 1) (feedkey "<Plug>(vsnip-expand-or-jump)" "")
                                (fallback))) [:i :s])
   "<S-Tab>"   (cmp.mapping (fn [fallback]
                              (if (cmp.visible) (cmp.select_prev_item)
                                (= (vim.fn.vsnip#jumpable -1) 1) (feedkey "<Plug>(vsnip-jump-prev)" "")
                                (fallback))) [:i :s])})

(local sources
  [[{:name "nvim_lsp"}
    {:name "nvim_lsp_signature_help"}
    {:name "vsnip"}
    {:name "path"}]
   [{:name "buffer" :option {:keyword_pattern "\\k\\+"}}]])

(local comparators
  [(fn [...] (cmp-buffer:compare_locality ...))
   cmp.config.compare.offset
   cmp.config.compare.exact
   cmp.config.compare.score
   under-compare.under
   cmp.config.compare.kind
   cmp.config.compare.sort_text
   cmp.config.compare.length
   cmp.config.compare.order])

(cmp.setup {:formatting {:fields [:kind :abbr]
                         :format format-item}
            :window {:completion {:border conf.borders
                                  :winhighlight highlight}
                     :documentation {:border conf.borders
                                     :winhighlight highlight}}
            :preselect cmp.PreselectMode.None
            :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
            :mapping (cmp.mapping.preset.insert mappings)
            :sources (cmp.config.sources (unpack sources))
            :sorting {:comparators comparators}})
