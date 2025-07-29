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
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd.colorscheme("rose-pine")
  end,
  opts = {
    highlight_groups = {
      RainbowDelimiterRed = { fg = dim_color("#eb6f92", 0.6) },
      RainbowDelimiterYellow = { fg = dim_color("#f6c177", 0.6) },
      RainbowDelimiterBlue = { fg = dim_color("#31748f", 0.6) },
      RainbowDelimiterOrange = { fg = dim_color("#ebbcba", 0.6) },
      RainbowDelimiterGreen = { fg = dim_color("#9ccfd8", 0.6) },
      RainbowDelimiterViolet = { fg = dim_color("#c4a7e7", 0.6) },
      RainbowDelimiterCyan = { fg = dim_color("#403d52", 0.6) },
    },
  },
}
