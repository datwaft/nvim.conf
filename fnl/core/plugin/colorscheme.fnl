(module core.plugin.colorscheme
  {autoload {plugin github-theme}})

(plugin.setup {:commentStyle "italic"
               :keywordStyle "italic"
               :functionStyle "italic"
               :variableStyle "italic"
               :darkSidebar true
               :darkFloat true})
