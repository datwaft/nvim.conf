(module core.plugin.lightspeed
  {autoload {plugin lightspeed}
   require-macros [core.macros]})

(global __core_repeat_ft
  (fn [reverse]
    (set plugin.ft.instant-repeat? true)
    (plugin.ft:to reverse plugin.ft.prev-t-like?)))

(noremap! [nx] ";" "<cmd>lua __core_repeat_ft(false)<cr>" :silent)
(noremap! [nx] "," "<cmd>lua __core_repeat_ft(true)<cr>" :silent)
