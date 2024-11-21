; extends

; test("@spell @string.documentation")
(call_expression
  function: (identifier) @_test
  (#eq? @_test "test")
  arguments: (arguments
    .
    [
      (string
        (string_fragment) @spell) @string.documentation
      (template_string
        (string_fragment) @spell) @string.documentation
    ]))

; test.something("@spell @string.documentation")
(call_expression
  function: (member_expression
              object: (identifier) @_test)
  (#eq? @_test "test")
  arguments: (arguments
    .
    [
      (string
        (string_fragment) @spell) @string.documentation
      (template_string
        (string_fragment) @spell) @string.documentation
    ]))

; test.describe("@spell @string.documentation")
(call_expression
  function: (member_expression
    object: (identifier) @_test
    (#eq? @_test "test")
    property: (property_identifier) @_property
    (#any-of? @_property "describe" "step"))
  arguments: (arguments
    .
    [
      (string
        (string_fragment) @spell) @string.documentation
      (template_string
        (string_fragment) @spell) @string.documentation
    ]))
