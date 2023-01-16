(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local cmp (require :cmp))
  (local luasnip (require :luasnip))

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
     "<Tab>"     (cmp.mapping #(if (cmp.visible) (cmp.select_next_item)
                                 (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
                                 ($)))
     "<S-Tab>"   (cmp.mapping #(if (cmp.visible) (cmp.select_prev_item)
                                 (luasnip.jumpable -1) (luasnip.jump -1)
                                 ($)))})

  ;;; =======
  ;;; Sources
  ;;; =======
  (local sources
    [[{:name "nvim_lsp"}
      {:name "nvim_lsp_signature_help"}
      {:name "treesitter"}
      {:name "luasnip"}
      {:name "path"}
      {:name "git"}]
     [{:name "buffer" :option {:keyword_pattern :\k\+}}
      {:name "spell" :option {:enable_in_context #(let [context (require :cmp.config.context)]
                                                    (context.in_treesitter_capture "spell"))}}]])

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
              :snippet {:expand #(luasnip.lsp_expand $.body)}
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
                       (pack "saadparwaiz1/cmp_luasnip" {:dependencies ["L3MON4D3/LuaSnip"]})
                       "lukas-reineke/cmp-under-comparator"
                       (pack "petertriho/cmp-git" {:dependencies ["nvim-lua/plenary.nvim"]})
                       "f3fora/cmp-spell"
                       "ray-x/cmp-treesitter"]
        : config})
 ;; Snippets
 (pack "L3MON4D3/LuaSnip"
       {:dependencies ["rafamadriz/friendly-snippets"]
        :config #((. (require :luasnip.loaders.from_vscode) :lazy_load))})]
