local conditions = require("heirline.conditions")

return {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  {
    provider = "[",
    hl = { fg = "overlay0" },
  },
  {
    provider = function()
      local names = {}
      for _, server in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        table.insert(names, server.name)
      end
      return table.concat(names, " ")
    end,
    hl = { fg = "green", bold = true },
  },
  {
    provider = "]",
    hl = { fg = "overlay0" },
  },
}
