(fn config []
  (local cmp (require :cmp))
  (local luasnip (require :luasnip))
  (local context (require :cmp.config.context))

  ;; Events
  (augroup! unlink-snippet-on-mode-change
    (clear!)
    (autocmd! ModeChanged ["s:n" "i:*"]
      #(when (and (?. luasnip :session :current_nodes $.buf)
                  (not (?. luasnip :session :jump_active)))
         (luasnip.unlink_current))
      {:desc "Forget the current snippet when leaving insert mode"}))

  ;; Mappings
  (local mappings
         {;; Scrolling
          "<C-b>"     (cmp.mapping.scroll_docs -4)
          "<C-f>"     (cmp.mapping.scroll_docs  4)
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

  ;; Sources
  (fn inside-string []
    (or (context.in_treesitter_capture "string")
        (context.in_syntax_group "String")))
  (fn inside-comment []
    (or (context.in_treesitter_capture "comment")
        (context.in_syntax_group "Comment")))
  (local sources
    {:lsp     {:name "nvim_lsp"}
     :luasnip {:name "luasnip"
               :entry_filter #(and (not (inside-string))
                                   (not (inside-comment)))}
     :path    {:name "path"}
     :buffer  {:name "buffer"
               :option {:keyword_pattern :\k\+}}
     :vimtex  {:name "vimtex"}
     })

  ;; nvim-cmp setup
  (cmp.setup
    {:preselect cmp.PreselectMode.None
     :snippet {:expand #(luasnip.lsp_expand $.body)}
     :sources (cmp.config.sources [sources.lsp
                                   sources.luasnip
                                   sources.path]
                                  [sources.buffer])
     :mapping (cmp.mapping.preset.insert mappings)})
  (cmp.setup.filetype "tex"
    {:sources (cmp.config.sources [sources.vimtex
                                   sources.luasnip
                                   sources.path]
                                  [sources.buffer])}))

[;; Completion
 (pack "hrsh7th/nvim-cmp"
       {:dependencies [;; Snippets
                       (pack "saadparwaiz1/cmp_luasnip" {:dependencies ["L3MON4D3/LuaSnip"]})
                       ;; Sources
                       (pack "hrsh7th/cmp-nvim-lsp" {:dependencies ["neovim/nvim-lspconfig"]})
                       "hrsh7th/cmp-buffer"
                       "hrsh7th/cmp-path"
                       "micangl/cmp-vimtex"
                       ]
       : config})
 ;; Snippets
 (pack "L3MON4D3/LuaSnip"
       {:version "2.*"
        :build "make install_jsregexp"
        :dependencies ["rafamadriz/friendly-snippets"]
        :config #(let [from-vscode (require :luasnip.loaders.from_vscode)]
                   (from-vscode.lazy_load))})
 ]
