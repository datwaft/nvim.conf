---@type LazySpec
return {
  -- Create directories when saving if necessary
  "jghauser/mkdir.nvim",
  -- Never invalidate undo files
  {
    "kevinhwang91/nvim-fundo",
    event = "BufReadPost",
    build = function()
      require("fundo").install()
    end,
    dependencies = { "kevinhwang91/promise-async" },
    config = true,
  },
}
