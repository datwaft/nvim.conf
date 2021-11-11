(local {: setup} (require :renamer))
(local map (require :renamer.mappings.utils))

(setup {:title "Rename"
        :padding {:top 0
                  :left 0
                  :right 0
                  :bottom 0}
        :border true
        :border_chars ["─" "│" "─" "│" "╭" "╮" "╯" "╰"]
        :show_refs true
        :with_qf_list true
        :mappings {"<C-h>" map.set_cursor_to_start
                   "<C-l>" map.set_cursor_to_end
                   "<C-i>" map.set_cursor_to_start
                   "<C-a>" map.set_cursor_to_end
                   "<C-e>" map.set_cursor_to_word_end
                   "<C-b>" map.set_cursor_to_word_start
                   "<C-c>" map.clear_line
                   "<C-u>" map.undo
                   "<C-r>" map.redo}})
