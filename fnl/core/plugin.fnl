(import-macros {: pack!
                : unpack!} :core.macro.pack)

;;; Essential
;; Plugin Manager
(pack! :wbthomason/packer.nvim)
;; Using Fennel for configuration
(pack! :rktjmp/hotpot.nvim)

;;; --------------------

; Initialize declared plugins
(unpack!)
