---@type LazySpec
return {
  -- Icons
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-mini/mini.icons" },
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
          {
            "diff",
            symbols = icons.git,
            source = function()
              const summary = vim.b.minidiff_summary
              return summary ? { added = summary.add, modified = summary.change, removed = summary.delete } : nil
            end,
          },
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
