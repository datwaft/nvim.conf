(module core.plugin.telescope
  {autoload {plugin telescope
             actions telescope.actions}
   require-macros [core.macros]})

;; Find files using Telescope command-line sugar
(noremap! [n] "<leader>ff" "<cmd>Telescope find_files<cr>")
(noremap! [n] "<leader>fg" "<cmd>Telescope live_grep<cr>")
(noremap! [n] "<leader>fb" "<cmd>Telescope buffers<cr>")
(noremap! [n] "<leader>fh" "<cmd>Telescope help_tags<cr>")

;; Suggest spelling
(noremap! [n] "zf" "<cmd>lua require'telescope.builtin'.spell_suggest{}<cr>" :silent)

;; Configure telescope
(plugin.setup {:defaults {:mappings {:i {"<ESC>" actions.close
                                         "<C-q>" actions.close
                                         "<M-q>" actions.close}}}})
