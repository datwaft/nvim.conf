(import-macros {: pack! : unpack!} :conf.macro.pack)

(local lisp-ft [:fennel
                :clojure
                :lisp
                :racket
                :scheme])

;;; ==========
;;; Essentials
;;; ==========
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel to configure neovim
(pack! "rktjmp/hotpot.nvim")
;; Dynamic LISP evaluation
(pack! "Olical/conjure")

;;; =========
;;; Aesthetic
;;; =========
;; Colorscheme
(pack! "wuelnerdotexe/vim-enfocado" {:as "colorscheme"
                                     :req "colorscheme"})
;; Statusline
(pack! "famiu/feline.nvim" {:req "feline"})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"
                                          :req "treesitter"
                                          :requires ["p00f/nvim-ts-rainbow"
                                                     "nvim-treesitter/nvim-treesitter-refactor"
                                                     "JoosepAlviste/nvim-ts-context-commentstring"]})
;; Treesitter-powered spelling
(pack! "lewis6991/spellsitter.nvim" {:init "spellsitter"
                                     :requires ["nvim-treesitter/nvim-treesitter"]})
;; Preview substitution
(pack! "markonm/traces.vim")
;; Color code highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :req "hexokinase"})
;; Indent lines
(pack! "lukas-reineke/indent-blankline.nvim" {:req "indent-blankline"})
;; Developer icons
(pack! "kyazdani42/nvim-web-devicons" {:req "devicons"})
;; Highlight matches
(pack! "kevinhwang91/nvim-hlslens" {:req "hlslens"})

;;; ============
;;; Text objects
;;; ============
;; General
(pack! "wellle/targets.vim")
;; Indent-level text objects
(pack! "michaeljsmith/vim-indent-object")
;; CamelCase text objects
(pack! "bkad/CamelCaseMotion" {:req "camel-case-motion"})
;; Whitespace text objects
(pack! "vim-utils/vim-space")

;;; ============
;;; Text Editing
;;; ============
;; Indentation inference
(pack! "tpope/vim-sleuth")
;; Parentheses inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft lisp-ft})

;;; =========
;;; Filetypes
;;; =========
;; Fennel
(pack! "bakpakin/fennel.vim")

;;; ==========
(unpack!)
