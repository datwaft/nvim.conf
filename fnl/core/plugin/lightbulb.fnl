(module core.plugin.lightbulb
  {autoload {plugin nvim-lightbulb}
   require-macros [core.macros]})

(augroup! update-lightbulb
          (autocmd! [CursorHold CursorHoldI] *
                    #(plugin.update_lightbulb {:sign {:enabled false}
                                               :virtual_text {:enabled true
                                                              :text ""}})))
(vim.cmd "highlight link LightBulbVirtualText Red")
