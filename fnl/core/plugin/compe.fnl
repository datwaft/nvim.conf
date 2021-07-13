(module core.plugin.compe
  {autoload {plugin compe
             a aniseed.core ; TODO: delete this
             m vimp}})

(set vim.opt.completeopt [:menuone :noselect])

(plugin.setup {:enabled true
               :autocomplete true
               :debug false
               :min_length 1
               :preselect "enable"
               :throttle_time 80
               :source_timeout 200
               :resolve_timeout 800
               :incomplete_delay 400
               :max_abbr_width 100
               :max_kind_width 100
               :max_menu_width 100
               :documentation {:border ["" "" "" " " "" "" "" " "]
                               :winhighlight "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder"
                               :max_width 120
                               :min_width 60
                               :max_height (math.floor (* vim.o.lines 0.3))
                               :min_height 1}
               :source {
                        :path true
                        :buffer true
                        :calc true
                        :nvim_lsp true
                        :nvim_lua true
                        :vsnip false
                        :ultisnips false
                        :luasnip false
                        :omni false
                        }})

(m.inoremap [:override :expr :silent] "<C-Space>" "compe#complete()")
(m.inoremap [:override :expr :silent] "<C-e>" "compe#close('<C-e>')")
(m.inoremap [:override :expr :silent] "<space>" "compe#confirm('<space>')")
(m.inoremap [:override :expr :silent] "<C-f>" "compe#scroll({ 'delta': +4 })")
(m.inoremap [:override :expr :silent] "<C-d>" "compe#scroll({ 'delta': -4 })")

(defn- check-backspace []
  (let [result (let [col (- (vim.fn.col ".") 1)]
                 (or (= col 0)
                     (-> (vim.fn.getline ".")
                         (: :sub col col)
                         (: :match "%s"))))]
    (if (a.nil? result)
      false
      result)))

(defn- tab-complete []
  (if
    (= (vim.fn.pumvisible) 1) "<C-n>"
    ; (= (vim.fn.call "vsnip#available" [1]) 1) "<Plug>(vsnip-expand-or-jump)"
    "<Tab>"))

(defn- s-tab-complete []
  (if
    (= (vim.fn.pumvisible) 1) "<C-p>"
    ; (= (vim.fn.call "vsnip#available" [-1]) 1) "<Plug>(vsnip-jump-prev)"
    "<S-Tab>"))

(m.inoremap [:override :expr :silent] "<Tab>" tab-complete)
(m.snoremap [:override :expr :silent] "<Tab>" tab-complete)
(m.inoremap [:override :expr :silent] "<S-Tab>" s-tab-complete)
(m.snoremap [:override :expr :silent] "<S-Tab>" s-tab-complete)
