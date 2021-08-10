(module core.plugin.which-key
  {autoload {plugin which-key}})

(plugin.setup
  {:plugins {:marks true
             :registers true
             :spelling {:enabled true
                        :suggestions 20}
             :presets {:operators true
                       :motions true
                       :text_objects true
                       :windows true
                       :nav true
                       :z true
                       :g true}}
   :operators {:gc "Comments"}
   :key_labels {}
   :icons {:breadcrumb "»"
           :separator ">"
           :group "+"}
   :window {:border "none"
            :position "bottom"
            :margin [1 0 1 0]
            :padding [2 2 2 2]}
   :layout {:height {:min 4
                     :max 25}
            :width {:min 20
                    :max 50}
            :spacing 3
            :align "left"}
   :ignore_missing false
   :hidden ["<silent>" "<cmd>" "<Cmd>" "<CMD>" "<CR>" "<cr>" "call" "lua" "^:" "^ "]
   :show_help true
   :triggers "auto"
   :triggers_blacklist {:i ["j" "k"]
                        :v ["j" "k"]}})
