local conditions = require("heirline.conditions")

return {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status = vim.b.gitsigns_status_dict
    self.status.added = self.status.added or 0
    self.status.removed = self.status.removed or 0
    self.status.changed = self.status.changed or 0
    self.has_changes = self.status.added ~= 0 or self.status.removed ~= 0 or self.status.changed ~= 0
  end,
  {
    provider = function(self)
      return self.status.head
    end,
    hl = { fg = "overlay0" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.status.added > 0 and ("+" .. self.status.added)
    end,
    hl = { fg = "green" },
  },
  {
    condition = function(self)
      return self.status.added > 0 and (self.status.removed > 0 or self.status.changed > 0)
    end,
    provider = ",",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.status.removed > 0 and ("-" .. self.status.removed)
    end,
    hl = { fg = "red" },
  },
  {
    condition = function(self)
      return self.status.removed > 0 and self.status.changed > 0
    end,
    provider = ",",
    hl = { fg = "overlay0" },
  },
  {
    provider = function(self)
      return self.status.changed > 0 and ("~" .. self.status.changed)
    end,
    hl = { fg = "yellow" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
    hl = { fg = "overlay0" },
  },
}
