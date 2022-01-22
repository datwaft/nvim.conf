(import-macros {: map!} :conf.macro.keybind)

(local {: setup
        : load_extension} (require :telescope))
(local actions (require :telescope.actions))
(local {:find_files find-files!
        :live_grep live-grep!
        :buffers buffers!
        :help_tags help-tags!
        :quickfix quickfix!
        :loclist loclist!} (require :telescope.builtin))

;; Search file by name
(map! [n] "<leader>ff" find-files!
          "Find a file")

;; Search file by content
(map! [n] "<leader>fg" live-grep!
          "Live grep a file")

;; Search buffer list
(map! [n] "<leader>fb" buffers!
          "Find a buffer")

;; Search help tags
(map! [n] "<leader>fh" help-tags!
          "Find a help tag")

;; Search quickfix list
(map! [n] "<leader>fq" quickfix!)

;; Search location list
(map! [n] "<leader>fk" loclist!)

;; Configure telescope
(setup {:defaults {:mappings {:i {"<ESC>" actions.close
                                  "<C-q>" actions.smart_send_to_qflist
                                  "<C-k>" actions.smart_send_to_loclist}}}})
(load_extension :fzy_native)
