local conditions = require("heirline.conditions")

return {
  condition = conditions.has_diagnostics,
  update = { "DiagnosticChanged", "BufEnter" },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  {
    provider = "![",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.errors > 0 and (icons.diagnostic.error .. self.errors)
    end,
    hl = { fg = "red" },
  },
  {
    condition = function(self)
      return self.errors > 0 and (self.warnings > 0 or self.info > 0 or self.hints > 0)
    end,
    provider = ",",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (icons.diagnostic.warn .. self.warnings)
    end,
    hl = { fg = "yellow" },
  },
  {
    condition = function(self)
      return self.warnings > 0 and (self.info > 0 or self.hints > 0)
    end,
    provider = ",",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.info > 0 and (icons.diagnostic.info .. self.info)
    end,
    hl = { fg = "sky" },
  },
  {
    condition = function(self)
      return self.info > 0 and self.hints > 0
    end,
    provider = ",",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (icons.diagnostic.hint .. self.hints)
    end,
    hl = { fg = "teal" },
  },
  {
    provider = "]",
    hl = { fg = "overlay0" },
  },
}
