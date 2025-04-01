; extends

; Artillery graphql queries
(block_mapping_pair
  key: _ @json
  (#eq? @json "json")
  value: (block_node
    (block_mapping
      (block_mapping_pair
        key: _ @query
        (#eq? @query "query")
        value: (block_node
          (block_scalar) @injection.content
          (#set! injection.language "graphql"))))))
