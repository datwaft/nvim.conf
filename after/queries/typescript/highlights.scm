;; extends

;; Playwright's `test("something", async () => {})`
(call_expression
  function: (identifier) @identifier
  arguments:
  (arguments
    .
    (string (string_fragment) @spell))
  (#eq? @identifier "test"))

;; Playwright's `test.describe("something", async () => {})`
(call_expression
  function:
    (member_expression
      object: (identifier) @identifier
      property: (property_identifier) @property_identifier)
  arguments:
    (arguments
      .
      (string (string_fragment) @spell))
  (#eq? @identifier "test")
  (#eq? @property_identifier "describe"))
