(module core.lsp
  {autoload {config lspconfig
             lua-dev lua-dev
             signature lsp_signature}})

(def- global-options {:on_attach #(signature.on_attach)})

(def- system_name (if
                    (= 1 (vim.fn.has "mac")) "macOS"
                    (= 1 (vim.fn.has "unix")) "Linux"
                    (= 1 (vim.fn.has "win32")) "Windows"))
(def- root_path (.. (vim.fn.expand "~") "/.local/share/nvim/lspinstall/lua-language-server"))
(def- binary (.. root_path "/bin/" system_name "/lua-language-server"))

(defn- deep-merge [t1 t2]
  (each [k v (pairs t2)]
    (if
      (and (table? v) (table? (. t1 k))) (deep-merge (. t1 k) (. t2 k))
      (tset t1 k v)))
  t1)

;;; ====================
;;; Bash Language Server
;;; ====================

(config.bashls.setup (merge global-options {}))

;;; =========================
;;; C and CPP Language Server
;;; =========================

(config.clangd.setup (merge global-options {}))

;;; =====================
;;; CMake Language Server
;;; =====================

(config.cmake.setup (merge global-options {}))

;;; ===================
;;; Lua Language Server
;;; ===================

(config.sumneko_lua.setup (deep-merge (lua-dev.setup {:lspconfig 
                                          (merge
                                            global-options
                                            {:cmd [binary "-E" (.. root_path "/main.lua")]})})
                                   {:settings {:Lua {:workspace {:preloadFileSize 500}}}}))

;;; ======================
;;; Python Language Server
;;; ======================

(config.pyright.setup (merge global-options {}))

;;; =================
;;; R Language Server
;;; =================

(config.r_language_server.setup (merge global-options {}))

;;; ====================
;;; Rust Language Server
;;; ====================

(config.rust_analyzer.setup (merge global-options {}))

;;; =========================================
;;; Javascript and Typescript Language Server
;;; =========================================

(config.tsserver.setup (merge global-options {}))

;;; ===================
;;; Vue Language Server
;;; ===================

(config.vuels.setup (merge global-options {}))
