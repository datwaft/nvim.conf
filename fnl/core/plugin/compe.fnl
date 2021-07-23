(module core.plugin.compe
  {autoload {plugin compe}
   require-macros [core.macros]})

(set! completeopt [:menuone :noselect])

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
                        :conjure true
                        :vsnip false
                        :ultisnips false
                        :luasnip false
                        :omni {:filetypes [:tex]}
                        }})

(noremap! [i] "<C-Space>" "compe#complete()" :expr :silent)
(noremap! [i] "<C-e>" "compe#close('<C-e>')" :expr :silent)
(noremap! [i] "<space>" "compe#confirm('<space>')" :expr :silent)
(noremap! [i] "<C-f>" "compe#scroll({'delta': +4})" :expr :silent)
(noremap! [i] "<C-d>" "compe#scroll({'delta': -4})" :expr :silent)

(noremap! [is] "<Tab>" #(if (= (vim.fn.pumvisible) 1) (t "<C-n>")
                          (t "<Tab>")) :expr :silent)

(noremap! [is] "<S-Tab>" #(if (= (vim.fn.pumvisible) 1) (t "<C-p>")
                            (t "<S-Tab>")) :expr :silent)
