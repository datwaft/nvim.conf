(import-macros {: noremap!
                : highlight!} :crux.lib.macro.vim)

(local dap (require :dap))

;;; Keybinds
(noremap! [n] "<A-b>" #(do (dap.toggle_breakpoint) ""))
(noremap! [n] "<A-B>" #(do (dap.toggle_breakpoint (vim.fn.input "Breakpoint condition: ")) ""))
(noremap! [n] "<A-L>" #(do (dap.toggle_breakpoint nil nil (vim.fn.input "Log point message: ")) ""))
(noremap! [n] "<A-s>" #(do (dap.continue) ""))
(noremap! [n] "<A-H>" #(do (dap.step_back) ""))
(noremap! [n] "<A-L>" #(do (dap.step_over) ""))
(noremap! [n] "<A-J>" #(do (dap.step_into) ""))
(noremap! [n] "<A-K>" #(do (dap.step_out) ""))

;;; Signs
(vim.fn.sign_define :DapBreakpoint {:text "●" :texthl "DapBreakpoint"})
(vim.fn.sign_define :DapBreakpointCondition {:text "●" :texthl "DapBreakpointCondition"})
(vim.fn.sign_define :DapLogPoint {:text "●" :texthl "DapLogPoint"})
(vim.fn.sign_define :DapStopped {:text "" :texthl "DapStopped"})
(vim.fn.sign_define :DapBreakpointRejected {:text "" :texthl "DapBreakpointRejected"})
