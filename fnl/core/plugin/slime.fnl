(module core.plugin.slime
  {require-macros [core.macros]})

(let! slime_target "tmux")
(let! slime_paste_file (vim.fn.tempname))
(let! slime_python_ipython 0)
(let! slime_default_config {:socket_name "default"
                            :target_pane "{last}"})
(let! slime_dont_ask_default 1)

; Global mappings
(map! [n] "<leader>s" "<plug>SlimeMotionSend")

; Lisp exclusive mappings
(augroup! lisp-exclusive-slime-mappings
          (autocmd! FileType lisp
                    #(do
                       (map! [v] "<localleader>E" "<C-c><C-c>")
                       (map! [n] "<localleader>E" "<plug>SlimeMotionSend")
                       (map! [n] "<localleader>ee" "<leader>sa)")
                       (map! [n] "<localleader>ew" "<leader>siw")
                       (map! [n] "<localleader>eb" "<leader>sid"))))
