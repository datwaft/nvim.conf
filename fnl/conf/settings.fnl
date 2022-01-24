(import-macros {: let!} :conf.macro.var)
(import-macros {: set!} :conf.macro.opt)

(local {: byte} string)

(local {: stdpath
        : expand} vim.fn)

(fn escape [combination]
  (vim.api.nvim_replace_termcodes combination true true true))

;;; =========================
;;; Local variable definition
;;; =========================
; Define configuration folder
(local configuration-folder (stdpath :config))

;;; =========================
;;; Environment configuration
;;; =========================
; Define python binary
(let! python3_host_prog (expand "$HOME/.pyenv/versions/neovim/bin/python"))
; Disable some providers
(let! loaded_python_provider 0)
(let! loaded_ruby_provider 0)
(let! loaded_perl_provider 0)

;;; ====================
;;; Editor configuration
;;; ====================
;; Filetype detection configuration
; Use filetype.lua
(let! do_filetype_lua 1)

;; File configuration
; Do not write backups
(set! nowritebackup)
; Do not create swap files
(set! noswapfile)

;; Indentation configuration
; Use spaces instead of tabs
(set! expandtab)
; Number of spaces used for each <tab> and auto-indent
(set! softtabstop -1)
(set! shiftwidth 0)
(set! tabstop 2)

;; Wrapping configuration
; Do not break words at the middle
(set! linebreak)
; Maintain indentation on break
(set! breakindent)
; Add characters after wrap
(set! breakindentopt ["shift:2"])
; Show character after wrap
(set! showbreak "↳ ")

;; Formatting configuration
(set! formatoptions [:q :j])

;; Spell-checking configuration
(set! spell)
(set! spelllang [:en])
(set! spelloptions [:camel])

;; Undo persistence
(set! undodir (.. configuration-folder "/undodir.nvim"))
(set! undofile)

;; CursorHold delay
(set! updatetime 500)

;;; ======================
;;; Terminal configuration
;;; ======================
;; Mouse support
(set! mouse :a)

;;; ====================
;;; Visual configuration
;;; ====================
;; True color
(set! termguicolors)

;; Line number
(set! number)
(set! relativenumber)

;; Status configuration
(set! noshowmode)

;; Characters configuration
; Show whitespace characters
(set! list)
; Define characters to show
(set! listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; Sign column
; Always show sign column
(set! signcolumn "auto:1-9")

;; Fold configuration
; Start with everything unfolded
(set! foldlevelstart 99)
; Fold format
(set! fillchars "fold: ")
(set! foldtext #(vim.fn.printf "   %-6d%s"
                               (- vim.v.foldend (+ vim.v.foldstart 1))
                               (vim.fn.getline vim.v.foldstart)))

;;; ========================
;;; Completion configuration
;;; ========================
;; Insert-mode completion
(set! infercase)
(set! shortmess+ :c)

;; Command-mode completion
(set! wildcharm (byte (escape "<tab>")))
(set! wildignorecase)

;;; ==========================
;;; Command-mode configuration
;;; ==========================
;; Search and replace
(set! ignorecase)
(set! smartcase)

;; Substitution
(set! gdefault)

;;; ===========================
;;; Miscellaneous configuration
;;; ===========================
;; Diff-mode
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; Lazy redraw
(set! lazyredraw)

;; Timeout for mappings
(set! timeoutlen 500)

;; LocalLeader
(let! maplocalleader (escape "<space>"))
