---@type LazySpec
return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  opts = {
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    windows = {
      autocomplete = {
        selection = "manual",
      },
    },
    nerd_font_variant = "mono",
    keymap = {
      accept = "<space>",
      select_prev = { "<Up>", "<C-k>", "<S-Tab>" },
      select_next = { "<Down>", "<C-j>", "<Tab>" },
    },
  },
}
