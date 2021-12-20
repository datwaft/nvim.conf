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
