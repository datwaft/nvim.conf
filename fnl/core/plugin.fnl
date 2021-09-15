(import-macros {: pack!
                : rock!
                : unpack!} :core.macro.pack)

;;; Essential
;; Plugin Manager
(pack! :wbthomason/packer.nvim)
;; Using Fennel for configuration
(pack! :rktjmp/hotpot.nvim)
;; Regex PCRE2 Library
(rock! :lrexlib-PCRE2 {:env {:PCRE2_DIR "/home/linuxbrew/.linuxbrew/Cellar/pcre2/10.37_1"}})

;;; --------------------

; Initialize declared plugins
(unpack!)
