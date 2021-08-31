(module core.plugin.wilder)

(vim.fn.wilder#setup {:modes [":" "/" "?"]
                      :next_key "<tab>"
                      :previous_key "<S-tab>"
                      :accept_key "<space>"
                      :reject_key "<esc>"})

(vim.cmd "call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter()}))")
