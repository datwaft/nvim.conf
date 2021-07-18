(module core.plugin.lspsaga
  {autoload {plugin lspsaga}
   require-macros [core.macros]})

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
(noremap! [n] "gh" "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>" :silent)

;; ------------
;; Code actions
;; ------------
(noremap! [n] "<leader>a" "<cmd>lua require'lspsaga.codeaction'.code_action()<cr>" :silent)
(noremap! [v] "<leader>a" ":<C-U>lua require'lspsaga.codeaction'.range_code_action()<cr>" :silent)

;; -------------
;; Documentation
;; -------------
; Show documentation
(noremap! [n] "K" "<cmd>lua require'lspsaga.hover'.render_hover_doc()<cr>" :silent)
; Scroll
(noremap! [n] "<C-f>" "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<cr>" :silent)
(noremap! [n] "<C-b>" "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<cr>" :silent)

;; ---------
;; Signature
;; ---------
(noremap! [n] "gs" "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<cr>" :silent)

;; ------
;; Rename
;; ------
(noremap! [n] "<leader>rn" "<cmd>lua require'lspsaga.rename'.rename()<cr>" :silent)

;; ------------------
;; Preview definition
;; ------------------
(noremap! [n] "gd" "<cmd>lua require'lspsaga.provider'.preview_definition()<cr>" :silent)

;; -----------
;; Diagnostics
;; -----------
; Show diagnostics
(noremap! [n] "<leader>d" "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>" :silent)
; Jump between diagnostics
(noremap! [n] "[e" "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>" :silent)
(noremap! [n] "]e" "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>" :silent)
