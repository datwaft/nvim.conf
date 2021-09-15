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
;;; Text Editing
;; Parentheses Inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft [:fennel :clojure :lisp]})

;;; --------------------

; Initialize declared plugins
(unpack!)
