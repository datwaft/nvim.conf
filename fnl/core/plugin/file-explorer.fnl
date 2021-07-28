(module core.plugin.file-explorer
  {require-macros [core.macros]})

(let! nvim_tree_side "left")
(let! nvim_tree_width 25)
(let! nvim_tree_ignore [".git" "node_modules" ".cache"])
(let! nvim_tree_gitignore 1)
(let! nvim_tree_auto_open 0)
(let! nvim_tree_auto_close 0)
(let! nvim_tree_quit_on_open 0)
(let! nvim_tree_follow 1)
(let! nvim_tree_indent_markers 1)
(let! nvim_tree_hide_dotfiles 1)
(let! nvim_tree_git_hl 1)
(let! nvim_tree_highlight_opened_files 0)
(let! nvim_tree_root_folder_modifier (table.concat [":t:gs?$?/.." (string.rep " " 1000) "?:gs?^??"]))
(let! nvim_tree_tab_open 0)
(let! nvim_tree_allow_resize 1)
(let! nvim_tree_disable_netrw 1)
(let! nvim_tree_hijack_netrw 0)
(let! nvim_tree_add_trailing 0)
(let! nvim_tree_group_empty 1)
(let! nvim_tree_lsp_diagnostics 1)
(let! nvim_tree_disable_window_picker 0)
(let! nvim_tree_hijack_cursor 1)
(let! nvim_tree_update_cwd 1)

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

(noremap! [n] "<C-n>" "<cmd>NvimTreeToggle<cr>")
