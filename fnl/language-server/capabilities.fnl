(let [(ok? cmp) (pcall require "cmp_nvim_lsp")]
  (if ok? (cmp.default_capabilities)
    (let [capabilities (vim.lsp.protocol.make_client_capabilities)]
      (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                                   :lineFoldingOnly true})
      capabilities)
    (vim.notify "Cannot create language server capabilities as `cmp_nvim_lsp` is not installed." vim.log.levels.WARN)))
