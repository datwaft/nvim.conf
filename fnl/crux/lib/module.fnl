(local {: ->bool} (require :crux.lib.flux))

(fn prequire [name]
  "Requires a module.
  If the module doesn't exist return `nil`."
  (let [(exists? m) (pcall #(require name))]
    (if exists? m
      nil)))

(fn exists? [name]
  "Returns if a module exists."
  (->bool (prequire name)))

{: prequire
 : exists?}
