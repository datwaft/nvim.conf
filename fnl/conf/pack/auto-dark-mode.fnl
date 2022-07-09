(import-macros {: set!} :themis.opt)
(local {:cmd cmd!} vim)

(local {: setup
        : init} (require :auto-dark-mode))

(setup {:update_interval 1000
        :set_dark_mode (fn []
                         (set! background "dark")
                         (cmd! "colorscheme enfocado"))
        :set_light_mode (fn []
                          (set! background "light")
                          (cmd! "colorscheme enfocado"))})
(init)
