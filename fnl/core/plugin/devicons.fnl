(module core.plugin.devicons
  {autoload {plugin nvim-web-devicons}})

(plugin.setup {:default true
               :override {:fnl {:icon ""
                                :color "#7bc45c"
                                :name "fennel"}}})
