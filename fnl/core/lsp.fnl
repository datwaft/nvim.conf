(module core.lsp
  {autoload {a aniseed.core
             config lspconfig
             lua-dev lua-dev
             signature lsp_signature}})

(def- global-options {:on_attach #(signature.on_attach)})

(def- system_name (if
                    (= 1 (vim.fn.has "mac")) "macOS"
                    (= 1 (vim.fn.has "unix")) "Linux"
                    (= 1 (vim.fn.has "win32")) "Windows"))
(def- root_path (.. (vim.fn.expand "~") "/.local/share/nvim/lspinstall/lua-language-server"))
(def- binary (.. root_path "/bin/" system_name "/lua-language-server"))

;;; ====================
;;; Bash Language Server
;;; ====================

(config.bashls.setup (a.merge global-options {}))

;;; =========================
;;; C and CPP Language Server
;;; =========================

(config.clangd.setup (a.merge global-options {}))

;;; =====================
;;; CMake Language Server
;;; =====================

(config.cmake.setup (a.merge global-options {}))

;;; ===================
;;; Lua Language Server
;;; ===================

(config.sumneko_lua.setup (lua-dev.setup {:lspconfig 
                                          (a.merge
                                            global-options
                                            {:cmd [binary "-E" (.. root_path "/main.lua")]})}))

;;; ======================
;;; Python Language Server
;;; ======================

(config.pyright.setup (a.merge global-options {}))

;;; =================
;;; R Language Server
;;; =================

(config.r_language_server.setup (a.merge global-options {}))

;;; ====================
;;; Rust Language Server
;;; ====================

(config.rust_analyzer.setup (a.merge global-options {}))

;;; =========================================
;;; Javascript and Typescript Language Server
;;; =========================================

(config.tsserver.setup (a.merge global-options {}))

;;; ===================
;;; Vue Language Server
;;; ===================

(config.vuels.setup (a.merge global-options {}))
