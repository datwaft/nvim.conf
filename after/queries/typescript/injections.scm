; extends

; <something>.locator("<css code>")
(call_expression
  function: (member_expression
    property: (property_identifier) @_locator
    (#any-of? @_locator "locator" "frameLocator"))
  arguments: (arguments
    (string (string_fragment) @injection.content)
    (#set! injection.language "css")))
