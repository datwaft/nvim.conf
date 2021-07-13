(module core.plugin.treesitter
  {autoload {config nvim-treesitter.configs}})

(config.setup
  {:ensure_installed :maintained
   :highlight {:enable true
               :additional_vim_regex_highlighting true}
   :indent {:enable false}
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
                          :keymaps {:af "@function.outer"
                                    :if "@function.inner"
                                    :ac "@class.outer"
                                    :ia "@parameter.inner"
                                    :aa "@parameter.outer"
                                    :ic "@class.inner"}}
                 :swap {:enable true
                        :swap_next {"<localleader>>" "@parameter.inner"}
                        :swap_previous {"<localleader><" "@parameter.inner"}}}
   :rainbow {:enable true
             :extended_mode true
             :max_file_lines 1000}
   :context_commentstring {:enable true}
   :autotag {:enable true}})

(set vim.opt.foldmethod :expr)
(vim.cmd "set foldexpr=nvim_treesitter#foldexpr()")
