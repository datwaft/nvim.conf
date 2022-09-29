(local {:global-options {:on_attach on-attach}} (require :conf.lsp))

(local mason-lspconfig (require :mason-lspconfig))
(local lspconfig (require :lspconfig))

(fn get-server [name]
  (let [servers (mason-lspconfig.get_installed_servers)]
    (if (vim.tbl_contains servers name)
      (values true (. lspconfig name))
      (values false nil))))

(local (ok jdtls) (get-server "jdtls"))

(when (= ok false)
  (vim.notify "mason-lspconfig: jdtls not found, please install it first" vim.log.levels.ERROR)
  (lua :return))

(local default-config jdtls.document_config.default_config)

;;; =============
;;; Configuration
;;; =============

(local config {:on_attach on-attach
               :cmd default-config.cmd
               :root_dir (default-config.root_dir)
               :settings {:java {:configuration {:runtimes [{:name "JavaSE-19" :path "/Library/Java/JavaVirtualMachines/zulu-19.jdk/Contents/Home"}
                                                            {:name "JavaSE-17" :path "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"}
                                                            {:name "JavaSE-11" :path "/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home"}
                                                            {:name "JavaSE-1.8" :path "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"}]}}}
               :init_options {:bundles {}}})

(let [jdtls (require :jdtls)]
  (jdtls.start_or_attach config))

;;; ======
;;; Events
;;; ======

(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

;; Organize imports on save
(augroup! jdtls-organize-imports-on-save
  (clear!)
  (autocmd! BufWritePre *.java '(let [params (vim.lsp.util.make_range_params)
                                      bufnr (vim.api.nvim_get_current_buf)]
                                  (set params.context {:diagnostics (vim.lsp.diagnostic.get_line_diagnostics bufnr)})
                                  (local (result err) (vim.lsp.buf_request_sync 0 "java/organizeImports" params))
                                  (if err
                                    (vim.notify (.. "Error on organize imports: " err)
                                                vim.log.levels.ERROR)
                                    (let [result (vim.tbl_values result)]
                                      (if (and result (. result 1 :result))
                                        (vim.lsp.util.apply_workspace_edit (. result 1 :result) "utf-16")))))))
