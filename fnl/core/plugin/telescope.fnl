(module core.plugin.telescope
  {autoload {m vimp
             plugin telescope
             actions telescope.actions}})

;; Find files using Telescope command-line sugar
(m.nnoremap [:override] "<leader>ff" "<cmd>Telescope find_files<cr>")
(m.nnoremap [:override] "<leader>fg" "<cmd>Telescope live_grep<cr>")
(m.nnoremap [:override] "<leader>fb" "<cmd>Telescope buffers<cr>")
(m.nnoremap [:override] "<leader>fh" "<cmd>Telescope help_tags<cr>")

;; Suggest spelling
(m.nnoremap [:override :silent] "zf"
            "<cmd>lua require'telescope.builtin'.spell_suggest{}<cr>")

;; Configure telescope
(plugin.setup {:defaults {:mappings {:i {"<ESC>" actions.close
                                         "<C-q>" actions.close
                                         "<M-q>" actions.close}}}})
