(import-macros {: let!
                : noremap!} :crux.lib.macro.vim)
(local {: setup} (require :nvim-tree))

(let! nvim_tree_ignore [".git" "node_modules" ".cache"])
(let! nvim_tree_gitignore 1)
(let! nvim_tree_hide_dotfiles 1)
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

(setup {:auto_close true
        :hijack_cursor true
        :update_cwd true
        :lsp_diagnostics true
        :update_focused_file {:enable true
                              :update_cwd true}})

(noremap! [n] "<C-n>" "<cmd>NvimTreeToggle<cr>")
