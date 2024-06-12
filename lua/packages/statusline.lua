---@type LazySpec
return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  opts = function()
    local conditions = require("heirline.conditions")

    FileName = require("packages.statusline.filename")
    Git = require("packages.statusline.git")
    Space = { provider = " " }
    Align = { provider = "%=" }

    return {
      statusline = { FileName, Space, Git },
      winbar = { FileName },
      opts = {
        colors = require("catppuccin.palettes").get_palette("mocha"),
        disable_winbar_cb = function(args)
          return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
            filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
          }, args.buf)
        end,
      },
    }
  end,
  init = function()
    -- Enable global statusline
    vim.opt.laststatus = 3
  end,
}
