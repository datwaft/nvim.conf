(import-macros {: noremap!
                : highlight!} :crux.lib.macro.vim)

(local dap (require :dap))

(noremap! [n] "<localleader><localleader>" #(do (dap.toggle_breakpoint) ""))
(noremap! [n] "<localleader>b" #(do (dap.toggle_breakpoint) ""))
(noremap! [n] "<localleader>B" #(do (dap.toggle_breakpoint (vim.fn.input "Breakpoint condition: ")) ""))
(noremap! [n] "<localleader>lp" #(do (dap.toggle_breakpoint nil nil (vim.fn.input "Log point message: ")) ""))
(noremap! [n] "<localleader>s" #(do (dap.continue) ""))
(noremap! [n] "<localleader>H" #(do (dap.step_back) ""))
(noremap! [n] "<localleader>L" #(do (dap.step_over) ""))
(noremap! [n] "<localleader>J" #(do (dap.step_into) ""))
(noremap! [n] "<localleader>K" #(do (dap.step_out) ""))
(noremap! [n] "<localleader>S" #(do (dap.repl.open) ""))

(vim.fn.sign_define :DapBreakpoint {:text "●" :texthl "DapBreakpoint"})
(vim.fn.sign_define :DapBreakpointCondition {:text "●" :texthl "DapBreakpointCondition"})
(vim.fn.sign_define :DapLogPoint {:text "●" :texthl "DapLogPoint"})
(vim.fn.sign_define :DapStopped {:text "" :texthl "DapStopped"})
(vim.fn.sign_define :DapBreakpointRejected {:text "" :texthl "DapBreakpointRejected"})
