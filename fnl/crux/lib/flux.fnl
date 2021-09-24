(local {: gmatch} string)

(fn ->str [o]
  "Convert an object of any type into a string value."
  (tostring o))

(fn ->bool [o]
  "Convert an object of any type into a boolean value.
  Only `nil` and `false` are equivalent to `false`, any other value is
  `true`"
  (if o true
    false))

(fn str->seq [s]
  "Convert an string into a sequence of characters."
  (icollect [c (gmatch s ".")] c))

(fn seq->set [xs]
  "Convert a sequence into a table of each value of the sequence as the
  key and the value being `true`."
  (collect [_ v (ipairs xs)] (values v true)))

{: ->str
 : ->bool
 : str->seq
 : seq->set}
