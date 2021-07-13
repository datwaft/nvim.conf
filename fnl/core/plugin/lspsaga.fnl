(module core.plugin.lspsaga
  {autoload {plugin lspsaga
             m vimp}})

(plugin.init_lsp_saga {:code_action_prompt {:enable true
                                            :sign false
                                            :sign_priority 20
                                            :virtual_text false}
                       :code_action_keys {:quit "q"
                                          :exec  "<CR>"}
                       :rename_action_keys {:quit "<M-q>"
                                            :exec "<CR>"}})

;; ------
;; Finder
;; ------
(m.nnoremap [:override :silent] "gh" "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>")

;; ------------
;; Code actions
;; ------------
(m.nnoremap [:override :silent] "<leader>a" "<cmd>lua require'lspsaga.codeaction'.code_action()<cr>")
(m.vnoremap [:override :silent] "<leader>a" ":<C-U>lua require'lspsaga.codeaction'.range_code_action()<cr>")

;; -------------
;; Documentation
;; -------------
; Show documentation
(m.nnoremap [:override :silent] "K" "<cmd>lua require'lspsaga.hover'.render_hover_doc()<cr>")
; Scroll
(m.nnoremap [:override :silent] "<C-f>" "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<cr>")
(m.nnoremap [:override :silent] "<C-b>" "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<cr>")

;; ---------
;; Signature
;; ---------
(m.nnoremap [:override :silent] "gs" "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<cr>")

;; ------
;; Rename
;; ------
(m.nnoremap [:override :silent] "<leader>rn" "<cmd>lua require'lspsaga.rename'.rename()<cr>")

;; ------------------
;; Preview definition
;; ------------------
(m.nnoremap [:override :silent] "gd" "<cmd>lua require'lspsaga.provider'.preview_definition()<cr>")

;; -----------
;; Diagnostics
;; -----------
; Show diagnostics
(m.nnoremap [:override :silent] "<leader>d" "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>")
; Jump between diagnostics
(m.nnoremap [:override :silent] "[e" "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>")
(m.nnoremap [:override :silent] "]e" "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>")
