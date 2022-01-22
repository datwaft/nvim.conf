(import-macros {: map!} :conf.macro.keybind)

(local {: setup
        : load_extension} (require :telescope))
(local actions (require :telescope.actions))

;; Find files using Telescope command-line sugar
(map! [n] "<leader>ff" "<cmd>Telescope find_files<cr>"
          "Find a file")
(map! [n] "<leader>fg" "<cmd>Telescope live_grep<cr>"
          "Live grep a file")
(map! [n] "<leader>fb" "<cmd>Telescope buffers<cr>"
          "Find a buffer")
(map! [n] "<leader>fh" "<cmd>Telescope help_tags<cr>"
          "Find a help tag")

;; Search quickfix list
(map! [n] "<leader>fq" "<cmd>Telescope quickfix<cr>")

;; Search location list
(map! [n] "<leader>fk" "<cmd>Telescope loclist<cr>")

;; Configure telescope
(setup {:defaults {:mappings {:i {"<ESC>" actions.close
                                  "<C-q>" actions.smart_send_to_qflist
                                  "<C-k>" actions.smart_send_to_loclist}}}})
(load_extension :fzy_native)
