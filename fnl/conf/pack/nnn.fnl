(import-macros {: map!} :conf.macro.keybind)

(local {: setup} (require :nnn))
(local {: concat} table)
(local {: setreg} vim.fn)

(setup {:command "nnn -o -C"
        :set_default_mappings 0
        :replace_netrw 0
        :action {"<C-t>" "tab split"
                 "<C-s>" "split"
                 "<C-v>" "vsplit"
                 "<C-o>" #(setreg "+" (concat $ "\n"))}})

(map! [n] "<C-n>" "<cmd>NnnPicker<cr>"
          "Open nnn")
