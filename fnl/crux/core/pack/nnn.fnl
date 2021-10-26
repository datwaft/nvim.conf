(import-macros {: noremap!
                : let!} :crux.lib.macro.vim)
(local {: setup} (require :nnn))
(local {: concat} table)

(setup {:command "nnn -o -C"
        :set_default_mappings 0
        :replace_netrw 0
        :explorer_layout {:window {:width 0.9
                                   :height 0.6
                                   :highlight "Comment"}}
        :action {"<C-t>" "tab split"
                 "<C-s>" "split"
                 "<C-v>" "vsplit"
                 "<C-o>" #(vim.fn.setreg "+" (concat $ "\n"))}})

(noremap! [n] "<leader>n" "<cmd>NnnExplorer<cr>"
          "Open nnn explorer")
