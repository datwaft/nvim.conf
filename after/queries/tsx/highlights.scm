; extends

((jsx_attribute
  (property_identifier) @att_name
  (#eq? @att_name "class")
  (string
    (string_fragment) @class_value))
  (#set! @class_value conceal "…"))
