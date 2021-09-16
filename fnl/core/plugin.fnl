(import-macros {: pack!
                : rock!
                : unpack!} :core.macro.pack)

(fn req [module]
  "A shortcut for building a require string for the plugin configuration.
  Intended for use with packer's configuration options.
  Will prefix the name with `core.plugin.` before requiring."
  (string.format "require('core.plugin.%s')" module))

;;; Essential
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel for configuration
(pack! "rktjmp/hotpot.nvim")
;; Regex PCRE2 Library
(rock! "lrexlib-pcre2")

;;; Aesthetic
(pack! "Pocco81/Catppuccino.nvim" {:as :colorscheme
                                   :config (req :colorscheme)})

;;; Text Editing
;; Parentheses Inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft [:fennel :clojure :lisp]})

;;; REPL
;; Lisp REPL
(pack! "Olical/conjure" {:config (req :conjure)})

;;; Filetypes
;; Fennel
(pack! "bakpakin/fennel.vim" {:ft [:fennel]})
(pack! "ekalinin/Dockerfile.vim" {:ft [:dockerfile]})

;;; --------------------

; Initialize declared plugins
(unpack!)
