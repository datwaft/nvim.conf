(import-macros {: pack!
                : rock!
                : unpack!} :crux.lib.macro.pack)
(local {: format} string)

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
                                   :req :colorscheme})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:as :treesitter
                                          :run ":TSUpdate"
                                          :req :treesitter})
(pack! "p00f/nvim-ts-rainbow" {:requires :treesitter})
(pack! "nvim-treesitter/nvim-treesitter-refactor" {:requires :treesitter})
(pack! "nvim-treesitter/nvim-treesitter-textobjects" {:requires :treesitter})
(pack! "JoosepAlviste/nvim-ts-context-commentstring" {:requires :treesitter})
;; Preview substitution
(pack! "markonm/traces.vim")
;; Color codes highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :req :hexokinase})
;; Indent lines
(pack! "lukas-reineke/indent-blankline.nvim" {:req :indent-blankline})
;; Developer icons
(pack! "kyazdani42/nvim-web-devicons" {:req :devicons})
;; Hihglight matches
(pack! "kevinhwang91/nvim-hlslens" {:req :hlslens})

;;; Text objects
;; Intent-level text object
(pack! "michaeljsmith/vim-indent-object")
;; CamelCase text objects
(pack! "bkad/CamelCaseMotion" {:req :camel-case-motion})
;; Whitespace text objects
(pack! "vim-utils/vim-space")

;;; Actions
;; Comment
(pack! "tpope/vim-commentary")
;; Surround
(pack! "machakann/vim-sandwich")

;;; Text Editing
;; Parentheses Inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft [:fennel :clojure :lisp]})

;;; REPL
;; Lisp REPL
(pack! "Olical/conjure" {:req :conjure
                         :ft [:fennel :clojure :lisp]})

;;; Filetypes
;; Fennel
(pack! "bakpakin/fennel.vim" {:ft [:fennel]})
;; Dockerfile
(pack! "ekalinin/Dockerfile.vim" {:ft [:Dockerfile :dockerfile]})

;;; --------------------

; Initialize declared plugins
(unpack!)
