(module core.plugin.wilder)

(vim.fn.wilder#setup {:modes [":" "/" "?"]})

(vim.cmd
  "call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter(),'left': [wilder#popupmenu_devicons()]}))")
