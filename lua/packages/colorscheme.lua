---@param color string e.g. "#12fa56"
---@param factor number e.g. 0.7
local function dim_color(color, factor)
  -- We first extract the number as an `integer`
  ---@type unknown, unknown, string
  local _, _, hex = color:find("^#(%w+)$")
  local number = tonumber(hex, 16)
  -- Then we extract the RGB components
  local r = bit.rshift(bit.band(number, 0xFF0000), 16)
  local g = bit.rshift(bit.band(number, 0x00FF00), 8)
  local b = bit.band(number, 0x0000FF)
  -- We then dim each color by a factor
  r = math.floor(r * factor)
  g = math.floor(g * factor)
  b = math.floor(b * factor)
  -- We then convert those RGB components into an `integer` again
  local dimmed_color = bit.lshift(r, 16) + bit.lshift(g, 8) + b
  -- And finally we return the `integer` converted into a hex string
  return ("#%06x"):format(dimmed_color)
end

---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
  ---@type CatppuccinOptions
  opts = {
    kitty = true,
    custom_highlights = function(colors)
      return {
        DiagnosticVirtualTextError = { style = {} },
        DiagnosticVirtualTextWarn = { style = {} },
        DiagnosticVirtualTextInfo = { style = {} },
        DiagnosticVirtualTextHint = { style = {} },
        DiagnosticVirtualTextOk = { style = {} },
        FzfLuaBorder = { fg = colors.blue },
        QuickFixLineNr = { fg = colors.peach },
        RainbowDelimiterRed = { fg = dim_color(colors.red, 0.5), style = { "bold" } },
        RainbowDelimiterYellow = { fg = dim_color(colors.yellow, 0.5), style = { "bold" } },
        RainbowDelimiterBlue = { fg = dim_color(colors.blue, 0.5), style = { "bold" } },
        RainbowDelimiterOrange = { fg = dim_color(colors.peach, 0.5), style = { "bold" } },
        RainbowDelimiterGreen = { fg = dim_color(colors.green, 0.5), style = { "bold" } },
        RainbowDelimiterViolet = { fg = dim_color(colors.mauve, 0.5), style = { "bold" } },
        RainbowDelimiterCyan = { fg = dim_color(colors.teal, 0.5), style = { "bold" } },
      }
    end,
    transparent_background = true,
  },
}
