local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

return utils.insert({
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}, {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, vim.bo.filetype == "help" and ":t" or ":.")
    if filename == "" then
      return "[No Name]"
    end
    if not conditions.width_percent_below(#filename, 0.30) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
}, {
  condition = function()
    return vim.bo.modified
  end,
  provider = "[+]",
  hl = { fg = "overlay0" },
}, {
  condition = function()
    return not vim.bo.modifiable
  end,
  provider = "[-]",
  hl = { fg = "overlay0" },
}, {
  condition = function()
    return vim.bo.readonly
  end,
  provider = "[RO]",
  hl = { fg = "overlay0" },
}, { provider = "%<" })
