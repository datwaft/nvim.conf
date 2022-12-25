(import-macros {: pack} :themis.pack.lazy)

(fn feedkey [key mode]
  (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes key true true true) mode true))

(fn config []
  (local cmp (require :cmp))

  ;;; =======
  ;;; Options
  ;;; =======
  (import-macros {: set!} :themis.opt)

  (set! completeopt [:menu :menuone :noselect])

  ;;; ========
  ;;; Mappings
  ;;; ========
  (local mappings
    {;; Scrolling
     "<C-b>"     (cmp.mapping.scroll_docs -4)
     "<C-f>"     (cmp.mapping.scroll_docs 4)
     ;; Completion
     "<C-Space>" (cmp.mapping.complete)
     "<C-e>"     (cmp.mapping.abort)
     "<Space>"   (cmp.mapping.confirm {:select false})
     "<CR>"      (cmp.mapping.confirm {:select false})
     "<Tab>"     (cmp.mapping (fn [fallback]
                                (if (cmp.visible) (cmp.select_next_item)
                                    (= (vim.fn.vsnip#available 1) 1) (feedkey "<Plug>(vsnip-expand-or-jump)" "")
                                    (fallback))) [:i :s])
     "<S-Tab>"   (cmp.mapping (fn [fallback]
                                (if (cmp.visible) (cmp.select_prev_item)
                                    (= (vim.fn.vsnip#jumpable -1) 1) (feedkey "<Plug>(vsnip-jump-prev)" "")
                                    (fallback))) [:i :s])})

  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
    [[{:name "nvim_lsp"}
      {:name "nvim_lsp_signature_help"}
      {:name "vsnip"}
      {:name "path"}
      {:name "git"}]
     [{:name "buffer" :option {:keyword_pattern "\\k\\+"}}]])

  ;;; ===========
  ;;; Comparators
  ;;; ===========
  (local cmp-buffer (require :cmp_buffer))
  (local under-compare (require :cmp-under-comparator))

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

  ;;; =========
  ;;; Aesthetic
  ;;; =========
  (fn format-item [entry item]
    ; Define kind icons
    (set item.kind (or (. conf.kind-icons item.kind) ""))
    ; Define menu labels
    (set item.menu (or (. conf.source-labels entry.source.name) ""))
    ; Return the item
    item)


  ;;; =====
  ;;; Setup
  ;;; =====
  (cmp.setup {:formatting {:fields [:kind :abbr]
                           :format format-item}
              :preselect cmp.PreselectMode.None
              :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
              :mapping (cmp.mapping.preset.insert mappings)
              :sources (cmp.config.sources (unpack sources))
              :sorting {:comparators comparators}})

  (let [cmp-git (require :cmp_git)]
    (cmp-git.setup)))

[;; Autocomplete
 (pack "hrsh7th/nvim-cmp"
       {:dependencies ["hrsh7th/cmp-nvim-lsp"
                       "hrsh7th/cmp-nvim-lsp-signature-help"
                       "hrsh7th/cmp-buffer"
                       "hrsh7th/cmp-path"
                       (pack "hrsh7th/cmp-vsnip" {:dependencies ["hrsh7th/vim-vsnip"]})
                       "lukas-reineke/cmp-under-comparator"
                       (pack "petertriho/cmp-git" {:dependencies ["nvim-lua/plenary.nvim"]})]
        : config})
 ;; Snippets
 (pack "hrsh7th/vim-vsnip"
       {:dependencies ["rafamadriz/friendly-snippets"]})]
