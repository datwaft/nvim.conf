;; Configuration
(vim.diagnostic.config
  {:underline {:severity {:min vim.diagnostic.severity.INFO}}
   :signs {:severity {:min vim.diagnostic.severity.HINT}}
   :virtual_text {:severity {:min vim.diagnostic.severity.INFO}}
   :float {:show_header false
           :source true}
   :update_in_insert false
   :severity_sort true})

;; Signs
(vim.fn.sign_define :DiagnosticSignError {:text " " :texthl "DiagnosticSignError"})
(vim.fn.sign_define :DiagnosticSignWarn  {:text " " :texthl "DiagnosticSignWarn"})
(vim.fn.sign_define :DiagnosticSignInfo  {:text " " :texthl "DiagnosticSignInfo"})
(vim.fn.sign_define :DiagnosticSignHint  {:text " " :texthl "DiagnosticSignHint"})
(vim.fn.sign_define :DiagnosticSignOk    {:text " " :texthl "DiagnosticSignOk"})

;; Show line diagnostics
(map! [n] "<leader>d" vim.diagnostic.open_float)

;; Go to diagnostic
(map! [n] "[d" vim.diagnostic.goto_prev)
(map! [n] "]d" vim.diagnostic.goto_next)

;; List diagnostics
(map! [n] "<leader>ld" vim.diagnostic.setqflist)
