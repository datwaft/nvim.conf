-- ========================
-- TREESITTER CONFIGURATION
-- ========================
-- Created by datwaft [github.com/datwaft]

return function()
   require('nvim-treesitter.configs').setup({
      ensure_installed = "maintained",
      highlight = {
         enable = true,
         disable = {},
      },
      indent = {
         enable = true
      },
      refactor = {
         highlight_definitions = { enable = true },
         highlight_current_scope = { enable = false },
         navigation = {
            enable = true,
            keymaps = {
               goto_next_usage = "<a-*>",
               goto_previous_usage = "<a-#>",
            },
         },
      },
   })
end
