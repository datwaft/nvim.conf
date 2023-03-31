(local capabilities
  (let [(ok? cmp) (pcall require "cmp_nvim_lsp")]
    (if ok? (cmp.default_capabilities)
      (vim.lsp.protocol.make_client_capabilities))))

(set capabilities.textDocument.foldingRange
     {:dynamicRegistration false
      :lineFoldingOnly true})

capabilities
