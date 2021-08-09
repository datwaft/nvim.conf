(module core.plugin.colorscheme
  {autoload {plugin github-theme}})

(plugin.setup {:commentStyle "italic"
               :keywordStyle "italic"
               :functionStyle "italic"
               :variableStyle "italic"
               :darkSidebar false
               :darkFloat false})
