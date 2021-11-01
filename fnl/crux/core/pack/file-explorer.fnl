(import-macros {: let!
                : noremap!} :crux.lib.macro.vim)
(local {: setup} (require :nvim-tree))

(let! nvim_tree_gitignore 1)
(let! nvim_tree_indent_markers 1)
(let! nvim_tree_show_icons {:git 1
                            :folders 1
                            :files 1
                            :folder_arrows 1})
(let! nvim_tree_icons {:default ""
                       :symlink ""
                       :git {:unstaged "✗"
                             :staged "✓"
                             :unmerged ""
                             :renamed "➜"
                             :untracked "★"
                             :deleted ""
                             :ignored "◌"}
                       :folder {:default ""
                                :open ""
                                :empty ""
                                :empty_open ""
                                :symlink ""
                                :symlink_open ""}})

(setup {:disable_netrw false
        :hijack_netrw false
        :auto_close true
        :hijack_cursor true
        :update_cwd true
        :diagnostics {:enable true
                      :icons {:error ""
                              :warning ""
                              :info ""
                              :hint ""}}
        :update_focused_file {:enable true
                              :update_cwd true}
        :filters {:dotfiles true}})

(noremap! [n] "<C-n>" "<cmd>NvimTreeToggle<cr>")
