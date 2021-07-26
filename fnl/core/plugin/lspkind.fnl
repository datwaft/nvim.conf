(module core.plugin.lspkind
  {autoload {plugin lspkind}})

(plugin.init {:with_text false
              :preset "default"
              :symbol_map {:Text ""
                           :Method "ƒ"
                           :Function ""
                           :Constructor ""
                           :Variable ""
                           :Class ""
                           :Interface "ﰮ"
                           :Module ""
                           :Property ""
                           :Unit ""
                           :Value ""
                           :Enum "了"
                           :Keyword ""
                           :Snippet "﬌"
                           :Color ""
                           :File ""
                           :Folder ""
                           :EnumMember ""
                           :Constant ""
                           :Struct ""}})
