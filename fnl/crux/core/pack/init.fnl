(import-macros {: pack!
                : rock!
                : unpack!} :crux.lib.macro.pack)
(local {: format} string)

(fn req [module]
  "A shortcut for building a require string for the plugin configuration.
  Intended for use with packer's configuration options.
  Will prefix the name with `core.plugin.` before requiring."
  (format "require('crux.core.pack.%s')" module))

;;; Essential
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel for configuration
(pack! "rktjmp/hotpot.nvim")
;; Regex PCRE2 Library
(rock! "lrexlib-pcre2")

;;; Aesthetic
;; Colorscheme
(pack! "Pocco81/Catppuccino.nvim" {:as :colorscheme
                                   :config (req :colorscheme)})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:as :treesitter
                                          :run ":TSUpdate"
                                          :config (req :treesitter)})
(pack! "p00f/nvim-ts-rainbow" {:requires :treesitter})
(pack! "nvim-treesitter/nvim-treesitter-refactor" {:requires :treesitter})
(pack! "nvim-treesitter/nvim-treesitter-textobjects" {:requires :treesitter})
(pack! "JoosepAlviste/nvim-ts-context-commentstring" {:requires :treesitter})
;; Preview substitution
(pack! "markonm/traces.vim")
;; Color codes highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :config (req :hexokinase)})

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
;; Dockerfile
(pack! "ekalinin/Dockerfile.vim" {:ft [:dockerfile]})

;;; --------------------

; Initialize declared plugins
(unpack!)
