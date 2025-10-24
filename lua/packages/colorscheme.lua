---@param color string e.g. "#12fa56"
---@return [number, number, number]
local function hex_to_rgb(color)
  -- We first extract the number as an `integer`
  ---@type unknown, unknown, string
  local _, _, hex = color:find("^#(%x+)$")
  local number = tonumber(hex, 16)
  -- Then we extract the RGB components
  local r = bit.rshift(bit.band(number, 0xFF0000), 16)
  local g = bit.rshift(bit.band(number, 0x00FF00), 8)
  local b = bit.band(number, 0x0000FF)
  return { r, g, b }
end

---@param color [number, number, number] e.g. { 18, 250, 86 }
---@return string
local function rgb_to_hex(color)
  -- We convert the RGB components into an `integer`
  local number = bit.lshift(color[1], 16) + bit.lshift(color[2], 8) + color[3]
  -- And finally we return the `integer` converted into a hex string
  return ("#%06x"):format(number)
end

---@param color string e.g. "#12fa56"
---@param background string e.g. "#12fa56"
---@param alpha number e.g. 0.7
---@return string
local function blend(color, background, alpha)
  local fg = hex_to_rgb(color)
  local bg = hex_to_rgb(background)
  local r = math.floor((alpha * fg[1]) + ((1 - alpha) * bg[1]) + 0.5)
  local g = math.floor((alpha * fg[2]) + ((1 - alpha) * bg[2]) + 0.5)
  local b = math.floor((alpha * fg[3]) + ((1 - alpha) * bg[3]) + 0.5)
  return rgb_to_hex({ r, g, b })
end

---@type LazySpec
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("rose-pine").setup(opts)

    -- Override some highlight groups that cannot be overridden using `highlight_groups`
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "rose-pine",
      group = vim.api.nvim_create_augroup("colorscheme-override", { clear = true }),
      callback = function()
        local palette = require("rose-pine.palette")
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
          sp = palette.muted,
          underdotted = true,
        })
      end,
    })

    vim.cmd.colorscheme("rose-pine")
  end,
  opts = function()
    local palette = require("rose-pine.palette")
    return {
      highlight_groups = {
        RainbowDelimiterRed = { fg = blend(palette.love, palette.base, 0.45) },
        RainbowDelimiterYellow = { fg = blend(palette.gold, palette.base, 0.45) },
        RainbowDelimiterBlue = { fg = blend(palette.pine, palette.base, 0.45) },
        RainbowDelimiterOrange = { fg = blend(palette.rose, palette.base, 0.45) },
        RainbowDelimiterGreen = { fg = blend(palette.foam, palette.base, 0.45) },
        RainbowDelimiterViolet = { fg = blend(palette.iris, palette.base, 0.45) },
        RainbowDelimiterCyan = { fg = blend(palette.text, palette.base, 0.45) },
        MarkviewCode = { bg = palette.surface },
        Character = { fg = palette.iris },
        BlinkCmpDocBorder = { bg = palette.highlight_low },
        QuickFixLine = { bg = palette.overlay, inherit = false },
        QuickFixFilename = { fg = palette.iris },
      },
    }
  end,
}
