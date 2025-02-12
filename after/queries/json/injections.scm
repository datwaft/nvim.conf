; extends

(document
  (object
    (pair
      key: (string
        (string_content) @key
        (#eq? @key "scripts"))
      value: (object
        (pair
          value: (string
            (string_content) @injection.content)
          (#set! injection.language "bash"))))))
