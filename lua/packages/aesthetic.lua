---@type LazySpec
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons", config = true } },
    opts = {
      options = {
        theme = "rose-pine",
        globalstatus = true,
        disabled_filetypes = {
          winbar = {
            "qf",
            "neo-tree",
            "aerial",
          },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "jj-vcs",
          {
            "branch",
            cond = || -> not require("lualine.components.jj-vcs.jj_branch").is_jj_workspace(),
          },
          { "diff", symbols = icons.git },
          { "diagnostics", symbols = icons.diagnostic },
        },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = " ",
              dos = " ",
              mac = " ",
            },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      winbar = {
        lualine_a = { "location" },
        lualine_b = { "progress" },
        lualine_c = { "filename" },
      },
      inactive_winbar = {
        lualine_a = { "location" },
        lualine_b = { "progress" },
        lualine_c = { "filename" },
      },
    },
  },
  -- Indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    ---@module "ibl"
    ---@type ibl.config
    opts = { scope = { enabled = false } },
  },
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    init = function()
      vim.g.rainbow_delimiters = {
        -- Avoid interfering with concealed-line sizing in LSP previews.
        ---@param bufnr integer
        ---@return boolean
        condition = function(bufnr)
          return vim.bo[bufnr].buftype ~= "nofile"
        end,
      }
    end,
  },
}
