(local config (require :lspconfig))
(local {:report_start report-start!
        :report_info report-info!
        :report_ok report-ok!
        :report_warn report-warn!
        :report_error report-error!} vim.health)
(local {: format} string)
(local {: nil?} (require :themis.lib.types))

(lambda executable? [command]
  (= 1 (vim.fn.executable command)))

(lambda report! [name]
  (assert (= :string (type name)) "expected string for name")
  (let [command (?. config name :cmd 1)]
    (if
      (nil? command) (report-warn! (format "%s: the command is not defined." name))
      (executable? command) (report-ok! (format "%s: the command '%s' is executable." name command))
      (report-error! (format "%s: the command '%s' is not executable." name command)))))

(lambda check! []
  (report-start! "LSP server executables")
  (let [configured-servers (config.available_servers)
        configured-servers (doto configured-servers (table.sort))]
    (if (= 0 (length configured-servers))
      (report-info! "no lsp servers have been configured.")
      (each [_ server (ipairs configured-servers)] (report! server)))))

{:check check!}