(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)
(local {:cmd cmd!} vim)
(local {:system system!} vim.fn)

(fn get-os []
  (if (= (package.config:sub 1 1) "\\") "win"
    (string.match (: (io.popen "uname -s") :read "*a") "Darwin") "darwin"
    "linux"))

(fn get-darwin-appearance []
  (system! "defaults read -g AppleInterfaceStyle")
  (if (= vim.v.shell_error 0) "dark"
    "light"))

(if (= (get-os) "darwin")
  (if (= (get-darwin-appearance) "dark")
    (set! background "dark")
    (set! background "light")))

(let! enfocado_style "nature")
(cmd! "colorscheme enfocado")
