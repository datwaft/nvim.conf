(import-macros {: noremap!} :crux.lib.macro.vim)

(local {: setup
        : load_extension} (require :telescope))
(local actions (require :telescope.actions))

;; Find files using Telescope command-line sugar
(noremap! [n] "<leader>ff" "<cmd>Telescope find_files<cr>"
          "Find a file")
(noremap! [n] "<leader>fg" "<cmd>Telescope live_grep<cr>"
          "Live grep a file")
(noremap! [n] "<leader>fb" "<cmd>Telescope buffers<cr>"
          "Find a buffer")
(noremap! [n] "<leader>fh" "<cmd>Telescope help_tags<cr>"
          "Find a help tag")

;; Configure telescope
(setup {:defaults {:mappings {:i {"<ESC>" actions.close
                                  "<C-q>" actions.close
                                  "<M-q>" actions.close}}}})
(load_extension :fzy_native)
