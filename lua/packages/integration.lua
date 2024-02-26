---@type LazySpec
return {
  -- Discord integration
  "andweeb/presence.nvim",
  -- LeetCode integration
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  -- REPL integration
  {
    "jpalardy/vim-slime",
    init = function(self)
      vim.g.slime_target = "tmux"
      vim.g.slime_paste_file = vim.fn.tempname()
      vim.g.slime_default_config = {
        socket_name = vim.fn.split(vim.env.TMUX, ",")[1],
        target_pane = "{last}",
      }
      vim.g.slime_dont_ask_default = 1
    end,
  },
}
