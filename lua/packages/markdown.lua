---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = function()
    local presets = require("markview.presets")
    return {
      preview = {
        icon_provider = "devicons",
      },
      markdown = {
        headings = vim.tbl_deep_extend("force", presets.headings.glow, {
          heading_1 = { sign = "" },
          heading_2 = { sign = "" },
        }),
        horizontal_rules = presets.horizontal_rules.thin,
        tables = presets.tables.single,
        code_blocks = { sign = false },
      },
    }
  end,
}
