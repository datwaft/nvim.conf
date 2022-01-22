(import-macros {: set!} :conf.macro.opt)
(import-macros {: let!} :conf.macro.var)
(local {: setup} (require :nvim-treesitter.configs))

(setup {:ensure_installed "maintained"
        :highlight {:enable true}
        :indent {:enable true}
        :rainbow {:enable true
                  :extended_mode true}
        :refactor {:highlight_definitions {:enable true}
                   :highlight_current_scope {:enable false}
                   :smart_rename {:enable true
                                  :keymaps {:smart_rename "<localleader>rn"}}
                   :navigation {:enable true
                                :keymaps {:goto_definition "<localleader>gd"
                                          :list_definitions "<localleader>ld"
                                          :list_definitions_toc "<localleader>td"
                                          :goto_next_usage "<a-*>"
                                          :goto_previous_usage "<a-#>"}}}
        :textobjects {:select {:enable true
                               :lookahead true
                               :keymaps {:if "@function.inner"
                                         :af "@function.outer"
                                         :ic "@class.inner"
                                         :ac "@class.outer"
                                         :ia "@parameter.inner"
                                         :aa "@parameter.outer"}}
                      :swap {:enable true
                             :swap_next {"<localleader>>" "@parameter.inner"}
                             :swap_previous {"<localleader><" "@parameter.inner"}}}
        :context_commentstring {:enable true}
        :matchup {:enable true}})

(set! foldmethod :expr)
(set! foldexpr "nvim_treesitter#foldexpr()")

