---@type LazySpec
return {
  -- Database
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = false,
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion" },
      { "tpope/vim-dotenv" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { "<C-w>q", "<cmd>DBUIToggle<cr>" },
    },
  },
}
