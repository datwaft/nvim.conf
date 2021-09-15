(import-macros {: pack!
                : rock!
                : unpack!} :core.macro.pack)

;;; Essential
;; Plugin Manager
(pack! :wbthomason/packer.nvim)
;; Using Fennel for configuration
(pack! :rktjmp/hotpot.nvim)
;; Regex PCRE2 Library
(rock! :lrexlib-pcre2)

;;; --------------------

; Initialize declared plugins
(unpack!)
