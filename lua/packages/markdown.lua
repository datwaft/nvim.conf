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
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.thin,
        tables = presets.tables.single,
      },
    }
  end,
}
