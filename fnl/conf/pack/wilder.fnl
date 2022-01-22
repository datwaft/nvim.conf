(local {: wilder#setup} vim.fn)
(local {:cmd cmd!} vim)

(wilder#setup {:modes [":" "/" "?"]})

(cmd! "call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter(),'left': [wilder#popupmenu_devicons()]}))")
