;; extends

;; <something>.locator("<css code>")
(call_expression
  function: (member_expression
              property: (property_identifier) @_locator
              (#eq? @_locator "locator"))
  arguments: (arguments
               [(string (string_fragment) @injection.content)
                (template_string (string_fragment) @injection.content)]
               (#set! injection.language "css")))
