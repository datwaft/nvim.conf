(module core.plugin.slime
  {require-macros [core.macros]})

(let! slime_target "tmux")
(let! slime_paste_file (vim.fn.tempname))
(let! slime_python_ipython 0)
(let! slime_default_config {:socket_name "default"
                            :target_pane "{last}"})
(let! slime_dont_ask_default 1)

(noremap! [n] "<leader>s" "<plug>SlimeMotionSend")
