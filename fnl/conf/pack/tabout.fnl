(local {: setup} (require :tabout))

(setup {:tabkey "<Tab>"
        :backwards_tabkey "<S-Tab>"
        :act_as_tab false
        :act_as_shift_tab false
        :enable_backwards true
        :completion false
        :tabouts [{:open "'" :close "'"}
                  {:open "\"" :close "\""}
                  {:open "`" :close "`"}
                  {:open "(" :close ")"}
                  {:open "[" :close "]"}
                  {:open "{" :close "}"}]
        :ignore_beginning false
        :exclude []})
