---@type LazySpec
return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    ---@type fun(self: LazyPlugin, keys: string[]):string|LazyKeys[]|string[])
    keys = function()
      local ss = require("smart-splits")
      return {
        { "<C-w>h", ss.move_cursor_left },
        { "<C-w>j", ss.move_cursor_down },
        { "<C-w>k", ss.move_cursor_up },
        { "<C-w>l", ss.move_cursor_right },
      }
    end,
  },
  "andweeb/presence.nvim",
}
