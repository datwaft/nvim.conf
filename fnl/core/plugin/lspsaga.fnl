(module core.plugin.lspsaga
  {autoload {plugin lspsaga}
   require-macros [core.macros]})

(plugin.init_lsp_saga {:code_action_prompt {:enable true
                                            :sign false
                                            :sign_priority 20
                                            :virtual_text false}
                       :code_action_keys {:quit "q"
                                          :exec  "<CR>"}
                       :rename_action_keys {:quit "<M-q>"
                                            :exec "<CR>"}})
