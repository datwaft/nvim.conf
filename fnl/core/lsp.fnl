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

(def- global-options
  {:on_attach
   (fn [client bufnr]
     (signature.on_attach {:bind true
                           :fix_pos true
                           :hint_enable false
                           :handler_opts {:border "single"}}))})

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
