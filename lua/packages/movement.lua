---@type LazySpec
return {
  {
    "chrisgrieser/nvim-spider",
    config = function()
      local lua = vim.system({ vim.fn.expand("~/.local/bin/mise"), "where", "lua@5.1" }, { text = true }):wait()
      assert(lua.code == 0, lua.stderr)
      package.cpath = package.cpath .. ";" .. vim.trim(lua.stdout) .. "/luarocks/lib/lua/5.1/?.so"
      require("lua-utf8")
      require("spider").setup()
    end,
    keys = {
      { mode = { "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<cr>", desc = "spider-w" },
      { mode = { "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<cr>", desc = "spider-e" },
      { mode = { "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<cr>", desc = "spider-b" },
    },
  },
  {
    "aaronik/treewalker.nvim",
    cond = || -> not vim.g.vscode,
    opts = {
      highlight = true,
    },
    keys = {
      { mode = { "n" }, "<S-Up>", "<cmd>Treewalker Up<cr>" },
      { mode = { "n" }, "<S-Down>", "<cmd>Treewalker Down<cr>" },
      { mode = { "n" }, "<S-Left>", "<cmd>Treewalker Left<cr>" },
      { mode = { "n" }, "<S-Right>", "<cmd>Treewalker Right<cr>" },
    },
  },
}
