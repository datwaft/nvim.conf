(fn ->str [o]
  (tostring o))

(fn ->bool [o]
  (if o true false))

(fn module/exists? [name]
  (->bool (pcall #(require name))))

{: ->str
 : ->bool
 : module/exists?}
