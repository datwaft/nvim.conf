(fn ->str [o]
  "Convert an object of any type into a string value."
  (tostring o))

(fn ->bool [o]
  "Convert an object of any type into a boolean value.
  Only `nil` and `false` are equivalent to `false`, any other value is
  `true`"
  (if o true
    false))

{: ->str
 : ->bool}
