-- ========================
-- TREESITTER CONFIGURATION
-- ========================
-- Created by datwaft [github.com/datwaft]

return function()
   require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained",
      highlight = {
         enable = true,
         disable = {},
      },
      indent = {
         enable = false
      },
      refactor = {
         highlight_definitions = { enable = true },
         highlight_current_scope = { enable = false },
         navigation = {
            enable = true,
            keymaps = {
               goto_next_usage = "<A-*>",
               goto_previous_usage = "<A-#>",
            },
         },
      },
   }
end
