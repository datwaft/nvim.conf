;; extends

;; Playwright's `test("something", async () => {})`
(call_expression
  function: (identifier) @identifier
  arguments:
  (arguments
    .
    (string (string_fragment) @spell))
  (#eq? @identifier "test"))

