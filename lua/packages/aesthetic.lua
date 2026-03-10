---@type LazySpec
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "rose-pine",
        globalstatus = true,
        disabled_filetypes = {
          winbar = {
            "qf",
            "neo-tree",
            "aerial",
            "Avante",
            "AvanteInput",
            "AvanteSelectedFiles",
            "sidekick_terminal",
            "REPL",
          },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "jj-vcs",
          {
            "branch",
            cond = function() return not require("lualine.components.jj-vcs.jj_branch").is_jj_workspace() end,
          },
          { "diff", symbols = icons.git },
          { "diagnostics", symbols = icons.diagnostic },
        },
        lualine_c = { "filename" },
        lualine_x = {
          {
            function() return " " end,
            color = function()
              local status = require("sidekick.status").get()
              if status then
                if status.kind == "Error" then return "DiagnosticError" end
                if status.busy then return "DiagnosticWarn" end
                return "Special"
              end
            end,
            cond = function()
              local status = require("sidekick.status")
              return status.get() ~= nil
            end,
          },
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
  {
    "folke/snacks.nvim",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      -- Enhance vim.ui.select
      picker = {},
      -- Enable image viewer
      image = { doc = { enabled = false } },
    },
  },
  -- Indentation lines
  {
    "saghen/blink.indent",
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    opts = {
      static = { char = "▏" },
      scope = {
        char = "▏",
        highlights = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      },
    },
  },
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  -- Prettify symbols
  {
    "Prgebish/sigil.nvim",
    lazy = false,
    opts = {
      filetypes = { "tex", "plaintex", "latex", "typst" },
      filetype_symbols = {
        tex = {
          { pattern = [[\alpha]], replacement = "α", boundary = "left" },
          { pattern = [[\beta]], replacement = "β", boundary = "left" },
          { pattern = [[\gamma]], replacement = "γ", boundary = "left" },
          { pattern = [[\delta]], replacement = "δ", boundary = "left" },
          { pattern = [[\epsilon]], replacement = "ε", boundary = "left" },
          { pattern = [[\zeta]], replacement = "ζ", boundary = "left" },
          { pattern = [[\eta]], replacement = "η", boundary = "left" },
          { pattern = [[\theta]], replacement = "θ", boundary = "left" },
          { pattern = [[\iota]], replacement = "ι", boundary = "left" },
          { pattern = [[\kappa]], replacement = "κ", boundary = "left" },
          { pattern = [[\lambda]], replacement = "λ", boundary = "left" },
          { pattern = [[\mu]], replacement = "μ", boundary = "left" },
          { pattern = [[\nu]], replacement = "ν", boundary = "left" },
          { pattern = [[\xi]], replacement = "ξ", boundary = "left" },
          { pattern = [[\pi]], replacement = "π", boundary = "left" },
          { pattern = [[\rho]], replacement = "ρ", boundary = "left" },
          { pattern = [[\sigma]], replacement = "σ", boundary = "left" },
          { pattern = [[\tau]], replacement = "τ", boundary = "left" },
          { pattern = [[\upsilon]], replacement = "υ", boundary = "left" },
          { pattern = [[\phi]], replacement = "φ", boundary = "left" },
          { pattern = [[\chi]], replacement = "χ", boundary = "left" },
          { pattern = [[\psi]], replacement = "ψ", boundary = "left" },
          { pattern = [[\omega]], replacement = "ω", boundary = "left" },
          { pattern = [[\Gamma]], replacement = "Γ", boundary = "left" },
          { pattern = [[\Delta]], replacement = "Δ", boundary = "left" },
          { pattern = [[\Theta]], replacement = "Θ", boundary = "left" },
          { pattern = [[\Lambda]], replacement = "Λ", boundary = "left" },
          { pattern = [[\Xi]], replacement = "Ξ", boundary = "left" },
          { pattern = [[\Pi]], replacement = "Π", boundary = "left" },
          { pattern = [[\Sigma]], replacement = "Σ", boundary = "left" },
          { pattern = [[\Upsilon]], replacement = "Υ", boundary = "left" },
          { pattern = [[\Phi]], replacement = "Φ", boundary = "left" },
          { pattern = [[\Psi]], replacement = "Ψ", boundary = "left" },
          { pattern = [[\Omega]], replacement = "Ω", boundary = "left" },
          { pattern = [[\to]], replacement = "→" },
          { pattern = [[\lt]], replacement = "<" },
          { pattern = [[\gt]], replacement = ">" },
          { pattern = [[\leq]], replacement = "≤" },
          { pattern = [[\geq]], replacement = "≥" },
          { pattern = [[\infty]], replacement = "∞" },
          { pattern = [[\dotsc]], replacement = "⋯" },
        },
      },
    },
    keys = function()
      local motions = require("sigil.motions")
      return {
        { "<Left>", motions.move_left, mode = { "n", "x" } },
        { "<Right>", motions.move_right, mode = { "n", "x" } },
      }
    end,
  },
}
