;; extends

;; See https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b?permalink_comment_id=5010114
((attribute
   (attribute_name) @att_name (#eq? @att_name "class")
   (quoted_attribute_value (attribute_value) @class_value))
 (#set! @class_value conceal "…"))
