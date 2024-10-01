; extends

; bind \cf 'something'
((command
  name: (word) @command_name
  argument: (single_quote_string) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "fish")
  (#eq? @command_name "bind"))
