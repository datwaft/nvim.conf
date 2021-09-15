(fn ->str [obj]
  (tostring obj))

(fn ->bool [obj]
  (if obj true false))

(fn module#exists? [name]
  (->bool (pcall #(require name))))

{: ->str
 : ->bool
 : module#exists?}
