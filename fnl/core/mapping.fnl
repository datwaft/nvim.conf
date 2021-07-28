(module core.mapping
  {require-macros [core.macros]})

; Use <space> to close wildmenu
(noremap! [c] "<space>" #(if
                           (= (vim.fn.wildmenumode) 1) (t "<C-y>")
                           (t "<space>")) :expr)

; Move to the beginning or end with H or L
(noremap! [n] "H" "^" :silent)
(noremap! [n] "L" "$" :silent)
(noremap! [i] "<C-h>" "<C-o>^" :silent)
(noremap! [i] "<C-l>" "<C-o>$" :silent)
(noremap! [c] "<C-h>" "<home>")
(noremap! [c] "<C-l>" "<end>")

; Allow moving the cursor through wrapped lines with j, k, <up> and <down>
(noremap! [nv] "j" #(if (= vim.v.count 0) (t "gj")
                      (if (> vim.v.count 5) (t "m'j") (t "j")))
          :silent :expr)
(noremap! [nv] "k" #(if (= vim.v.count 0) (t "gk")
                      (if (> vim.v.count 5) (t "m'j") (t "k")))
          :silent :expr)
(noremap! [nv] "<down>" #(if (= vim.v.count 0) (t "gj")
                           (if (> vim.v.count 5) (t "m'<down>") (t "<down>")))
          :silent :expr)
(noremap! [i] "<down>" #(if (= vim.v.count 0) (t "<C-o>gj")
                          (if (> vim.v.count 5) (t "m'<down>") (t "<down>")))
          :silent :expr)
(noremap! [nv] "<up>" #(if (= vim.v.count 0) (t "gk")
                         (if (> vim.v.count 5) (t "m'<up>") (t "<up>")))
          :silent :expr)
(noremap! [i] "up" #(if (= vim.v.count 0) (t "<C-o>gk")
                      (if (> vim.v.count 5) (t "m'<up>") (t "<up>")))
          :silent :expr)

; Use Y to copy from the cursor to the end
(noremap! [n] "Y" "y$" :silent)

; Execute macro fast
(noremap! [xn] "Q" ":normal @@<cr>" :silent)

; Move lines up and down
(noremap! [n] "<C-k>" ":m-2<CR>" :silent)
(noremap! [n] "<C-j>" ":m+<CR>" :silent)
(noremap! [n] "<C-up>" ":m-2<CR>" :silent)
(noremap! [n] "<C-down>" ":m+<CR>" :silent)

;;; ============
;;; Text objects
;;; ============

;; Line object
; Inner line
(noremap! [xo] "il" ":<C-u>normal! g_v^<cr>" :silent)
; Around line
(noremap! [xo] "al" ":<C-u>normal! $v0<cr>" :silent)

;; Document object
; Inner document
(noremap! [x] "id" ":<C-u>normal! G$Vgg0<cr>" :silent)
(noremap! [o] "id" ":<C-u>normal! GVgg<cr>" :silent)

;;; ============
;;; LSP Mappings
;;; ============

(defn- exists? [module-name]
  "This function verifies if a module exists returning nil if it doesn't and
  returning the module if it does"
  (let [(ok?# content#) (pcall require module-name)]
    (if ok?# content# nil)))

; Use K to show the documentation
(noremap! [n] "K" "<cmd>lua vim.lsp.buf.hover()<cr>" :silent)

; Use <leader>a to open the code-actions menu
(when (exists? :lspsaga)
  (noremap! [n] "<leader>a" "<cmd>Lspsaga code_action<cr>" :silent)
  (noremap! [v] "<leader>a" "<cmd>Lspsaga range_code_action<cr>" :silent))

; Use <leader>d to display the diagnostics for the current line
(when (exists? :lspsaga)
  (noremap! [n] "<leader>d" "<cmd>Lspsaga show_line_diagnostics<cr>" :silent))

; Use <leader>D to display a list of diagnostics
(when (exists? :trouble)
  (noremap! [n] "<leader>D" "<cmd>TroubleToggle<cr>" :silent))

; Use <leader>ld to display a list of diagnostics for the current file
(when (exists? :trouble)
  (noremap! [n] "<leader>ld" "<cmd>TroubleToggle lsp_document_diagnostics<cr>"
            :silent))

; Use <leader>lD to display a list of diagnostics for the workspace
(when (exists? :trouble)
  (noremap! [n] "<leader>lD" "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>"
            :silent))

; Use [d and ]d to jump between diagnostics
(when (exists? :lspsaga)
  (noremap! [n] "[d" "<cmd>Lspsaga diagnostic_jump_prev<cr>" :silent)
  (noremap! [n] "]d" "<cmd>Lspsaga diagnostic_jump_next<cr>" :silent))

; Use <leader>lr to display a list of references for the symbol below the
; cursor
(when (exists? :trouble)
  (noremap! [n] "<leader>lr" "<cmd>TroubleToggle lsp_references<cr>"
            :silent))

; Use gd to go to the definition of the symbol below the cursor
(noremap! [n] "gd" "<cmd>lua vim.lsp.buf.definition()<cr>" :silent)

; Use gt to go to the type definition of the symbol below the cursor
(noremap! [n] "gt" "<cmd>lua vim.lsp.buf.type_definition()<cr>" :silent)

; Use <leader>pd to preview the definition of the symbol below the cursor
(when (exists? :lspsaga)
  (noremap! [n] "<leader>pd" "<cmd>Lspsaga preview_definition<cr>" :silent))

; Use <leader>ps to preview the signature of the symbol below the cursor
(when (exists? :lspsaga)
  (noremap! [n] "<leader>ps" "<cmd>Lspsaga signature_help<cr>" :silent))

; Use <leader>rn to rename the symbol below the cursor
(when (exists? :lspsaga)
  (noremap! [n] "<leader>rn" "<cmd>Lspsaga rename<cr>" :silent))
