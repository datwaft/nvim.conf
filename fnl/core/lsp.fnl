(module core.lsp
  {autoload {config lspconfig
             lua-dev lua-dev
             signature lsp_signature}
   require-macros [core.macros]})

(defn- deep-copy [obj]
  (if (table?)
    (collect [k v (pairs obj)]
      (values (deep-copy k) (deep-copy v)))
    obj))

(defn- deep-merge [obj1 obj2]
  (match [obj1 obj2]
    [nil nil] nil
    [nil _] (deep-copy obj2)
    [_ nil] (deep-copy obj1)
    (where _ (or (not (table? obj1))
                 (not (table? obj2)))) (deep-copy obj1)
    _ (do
        (var aux (deep-copy obj2))
        (each [key value (pairs obj1)]
          (tset aux key (deep-merge value (. aux key))))
        aux)))

(defn- exists? [module-name]
  "This function verifies if a module exists returning nil if it doesn't and
  returning the module if it does"
  (let [(ok?# content#) (pcall require module-name)]
    (if ok?# content# nil)))

(defn- on-attach [client bufnr]
  ;; --------
  ;; Mappings
  ;; --------
  ; Use K to show the documentation
  (noremap! [n :buffer] "K" "<cmd>lua vim.lsp.buf.hover()<cr>")
  ; Use <leader>a to open the code-actions menu
  (when (exists? :lspsaga)
    (noremap! [n :buffer] "<leader>a" "<cmd>Lspsaga code_action<cr>")
    (noremap! [v :buffer] "<leader>a" "<cmd>Lspsaga range_code_action<cr>"))
  ; Use <leader>d to display the diagnostics for the current line
  (when (exists? :lspsaga)
    (noremap! [n :buffer] "<leader>d" "<cmd>Lspsaga show_line_diagnostics<cr>"))
  ; Use <leader>D to display a list of diagnostics
  (when (exists? :trouble)
    (noremap! [n :buffer] "<leader>D" "<cmd>TroubleToggle<cr>"))
  ; Use <leader>ld to display a list of diagnostics for the current file
  (when (exists? :trouble)
    (noremap! [n :buffer] "<leader>ld" "<cmd>TroubleToggle lsp_document_diagnostics<cr>"))
  ; Use <leader>lD to display a list of diagnostics for the workspace
  (when (exists? :trouble)
    (noremap! [n :buffer] "<leader>lD" "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>"))
  ; Use [d and ]d to jump between diagnostics
  (when (exists? :lspsaga)
    (noremap! [n :buffer] "[d" "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    (noremap! [n :buffer] "]d" "<cmd>Lspsaga diagnostic_jump_next<cr>"))
  ; Use <leader>lr to display a list of references for the symbol below the cursor
  (when (exists? :trouble)
    (noremap! [n :buffer] "<leader>lr" "<cmd>TroubleToggle lsp_references<cr>"))
  ; Use gd to go to the definition of the symbol below the cursor
  (noremap! [n :buffer] "gd" "<cmd>lua vim.lsp.buf.definition()<cr>")
  ; Use gt to go to the type definition of the symbol below the cursor
  (noremap! [n :buffer] "gt" "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  ; Use <leader>pd to preview the definition of the symbol below the cursor
  (when (exists? :lspsaga)
    (noremap! [n :buffer] "<leader>pd" "<cmd>Lspsaga preview_definition<cr>"))
  ; Use <leader>ps to preview the signature of the symbol below the cursor
  (when (exists? :lspsaga)
    (noremap! [n :buffer] "<leader>ps" "<cmd>Lspsaga signature_help<cr>"))
  ; Use <leader>rn to rename the symbol below the cursor
  (when (exists? :lspsaga)
    (noremap! [n :buffer] "<leader>rn" "<cmd>Lspsaga rename<cr>"))
  ;; ---------
  ;; Signature
  ;; ---------
  (signature.on_attach {:bind true
                        :fix_pos true
                        :hint_enable false
                        :handler_opts {:border "single"}}))

(def- global-options {:on_attach on-attach})

;;; ====================
;;; Bash Language Server
;;; ====================

(config.bashls.setup (deep-merge global-options {}))

;;; =========================
;;; C and CPP Language Server
;;; =========================

(config.clangd.setup (deep-merge global-options {}))

;;; =====================
;;; CMake Language Server
;;; =====================

(config.cmake.setup (deep-merge global-options {}))

;;; ===================
;;; Lua Language Server
;;; ===================

(let [system-name (if
                    (has? "mac") "macOS"
                    (has? "unix") "Linux"
                    (has? "win32") "Windows")
      root-path (.. (vim.fn.expand "~") "/.local/share/nvim/lspinstall/lua-language-server")
      binary-path (.. root-path "/bin/" system-name "/lua-language-server")]
  (config.sumneko_lua.setup (deep-merge
                              (lua-dev.setup {:lspconfig 
                                              (deep-merge
                                                global-options
                                                {:cmd [binary-path "-E" (.. root-path "/main.lua")]})})
                              {:settings {:Lua {:workspace {:preloadFileSize 500}}}})))

;;; ======================
;;; Python Language Server
;;; ======================

(config.pyright.setup (deep-merge global-options {}))

;;; =================
;;; R Language Server
;;; =================

(config.r_language_server.setup (deep-merge global-options {}))

;;; ====================
;;; Rust Language Server
;;; ====================

(config.rust_analyzer.setup (deep-merge global-options {}))

;;; =========================================
;;; Javascript and Typescript Language Server
;;; =========================================

(config.tsserver.setup (deep-merge global-options {}))

;;; ===================
;;; Vue Language Server
;;; ===================

(config.vuels.setup (deep-merge global-options {}))

;;; ====================
;;; JSON Language Server
;;; ====================

(config.jsonls.setup (deep-merge global-options {}))

;;; =======================
;;; Clojure Language Server
;;; =======================

(config.clojure_lsp.setup (deep-merge global-options {}))
