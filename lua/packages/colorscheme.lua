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
    custom_highlights = function(_)
      return {
        DiagnosticVirtualTextError = { style = {} },
        DiagnosticVirtualTextWarn = { style = {} },
        DiagnosticVirtualTextInfo = { style = {} },
        DiagnosticVirtualTextHint = { style = {} },
        DiagnosticVirtualTextOk = { style = {} },
      }
    end,
    transparent_background = true,
  },
}
