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
  (buf-noremap! [n] "K" "<cmd>lua vim.lsp.buf.hover()<cr>")
  ; Use <leader>a to open the code-actions menu
  (when (exists? :lspsaga)
    (buf-noremap! [n] "<leader>a" "<cmd>Lspsaga code_action<cr>")
    (buf-noremap! [v] "<leader>a" "<cmd>Lspsaga range_code_action<cr>"))
  ; Use <leader>d to display the diagnostics for the current line
  (when (exists? :lspsaga)
    (buf-noremap! [n] "<leader>d" "<cmd>Lspsaga show_line_diagnostics<cr>"))
  ; Use <leader>D to display a list of diagnostics
  (when (exists? :trouble)
    (buf-noremap! [n] "<leader>D" "<cmd>TroubleToggle<cr>"))
  ; Use <leader>ld to display a list of diagnostics for the current file
  (when (exists? :trouble)
    (buf-noremap! [n] "<leader>ld" "<cmd>TroubleToggle lsp_document_diagnostics<cr>"))
  ; Use <leader>lD to display a list of diagnostics for the workspace
  (when (exists? :trouble)
    (buf-noremap! [n] "<leader>lD" "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>"))
  ; Use [d and ]d to jump between diagnostics
  (when (exists? :lspsaga)
    (buf-noremap! [n] "[d" "<cmd>Lspsaga diagnostic_jump_prev<cr>"
                        (buf-noremap! [n] "]d" "<cmd>Lspsaga diagnostic_jump_next<cr>")))
  ; Use <leader>lr to display a list of references for the symbol below the cursor
  (when (exists? :trouble)
    (buf-noremap! [n] "<leader>lr" "<cmd>TroubleToggle lsp_references<cr>"))
  ; Use gd to go to the definition of the symbol below the cursor
  (buf-noremap! [n] "gd" "<cmd>lua vim.lsp.buf.definition()<cr>")
  ; Use gt to go to the type definition of the symbol below the cursor
  (buf-noremap! [n] "gt" "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  ; Use <leader>pd to preview the definition of the symbol below the cursor
  (when (exists? :lspsaga)
    (buf-noremap! [n] "<leader>pd" "<cmd>Lspsaga preview_definition<cr>"))
  ; Use <leader>ps to preview the signature of the symbol below the cursor
  (when (exists? :lspsaga)
    (buf-noremap! [n] "<leader>ps" "<cmd>Lspsaga signature_help<cr>"))
  ; Use <leader>rn to rename the symbol below the cursor
  (when (exists? :lspsaga)
    (buf-noremap! [n] "<leader>rn" "<cmd>Lspsaga rename<cr>"))
  ; Use <leader>= to format the current buffer
  (buf-noremap! [n] "<leader>=" "<cmd>lua vim.lsp.buf.formatting()<cr>")
  (when client.resolved_capabilities.document_range_formatting
    (buf-noremap! [n] "<leader>=" "<cmd>lua vim.lsp.buf.formatting()<cr>"))
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

;;; ===================
;;; EFM Language Server
;;; ===================

(let [formatters {:luafmt {:formatCommand "lua-format -i"
                           :formatStdin true}
                  :prettierd {:formatCommand "prettierd \"${INPUT}\""
                              :formatStdin true
                              :env [(string.format "PRETTIERD_DEFAULT_CONFIG=%s"
                                                   (vim.fn.expand "~/.config/nvim/utils/linter-config/.prettierrc.json"))]}}
      languages {:lua [formatters.luafmt]
                 :javascript [formatters.prettierd]
                 :typescript [formatters.prettierd]}]
  (config.efm.setup (deep-merge global-options
                                {:init_options {:documentFormatting true
                                                :codeAction true}
                                 :settings {:rootMarkers [".git/"]
                                            :log_level 1
                                            :log_file "~/efm.log"
                                            :languages languages}
                                 :filetypes (vim.tbl_keys languages)})))
