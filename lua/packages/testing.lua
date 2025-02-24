---@type LazySpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    -- Adapters
    "thenbe/neotest-playwright",
    -- Dependencies
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  opts = function()
    return {
      adapters = {
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        }),
      },
      consumers = {
        playwright = require("neotest-playwright.consumers").consumers,
      },
    }
  end,
  keys = function()
    return {
      {
        "got",
        ---@diagnostic disable-next-line: undefined-field
        function() require("neotest").playwright.attachment() end,
      },
      { "gor", function() require("neotest").run.run() end },
      { "goR", function() require("neotest").run.run(vim.fn.expand("%")) end },
      { "gos", function() require("neotest").run.stop() end },
      { "goa", function() require("neotest").run.attach() end },
      { "<C-w>o", function() require("neotest").output.open({ auto_close = true }) end },
      { "<C-w>O", function() require("neotest").summary.toggle() end },
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("neotest-summary-filetype", { clear = true }),
      pattern = { "neotest-summary" },
      callback = function() vim.opt_local.wrap = false end,
    })
  end,
}
