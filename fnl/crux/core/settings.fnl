(import-macros {: set!
                : let!
                : t} :crux.lib.macro.vim)
(local {: extcmd!} (require :crux.lib.vim))
(local {: byte} string)

;;; Local variable definition
; Define configuration folder
(local configuration-folder (vim.fn.stdpath :config))

;;; Environment configuration
; Define python binary
(let! python3_host_prog (extcmd! "command -v python"))

;;; Editor configuration

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

;; Format configuration
(set! formatoptions [:q :j])

;; Spell-checking configuration
(set! spell)
(set! spelllang [:en])
(set! spelloptions [:camel])

;; Undo persistence
(set! undodir (.. configuration-folder "/undodir.nvim"))
(set! undofile)
 
;;; Terminal configuration

;; Mouse support
(set! mouse :a)

;;; Visual configuration

;; True color
(set! termguicolors)

;; Line number
(set! number)
(set! relativenumber)

;; Status configuration
(set! noshowmode)

;; Column configuration
(set! colorcolumn [81])

;; Characters configuration
; Show whitespace characters
(set! list)
; Define characters to show
(set! listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; Sign column
; Always show sign column
(set! signcolumn :yes)

;; Fold configuration
; Start with everything unfolded
(set! foldlevelstart 99)
; Fold format
(set! fillchars "fold: ")
(set! foldtext #(vim.fn.printf "   %-6d%s"
                               (- vim.v.foldend (+ vim.v.foldstart 1))
                               (vim.fn.getline vim.v.foldstart)))

;;; Completion configuration

;; Insert-mode completion
(set! infercase)
(set! shortmess+ :c)

;; Command-mode completion
(set! wildcharm (byte (t "<tab>")))
(set! wildignorecase)

;;; Command configuration

;; Search and replace
(set! ignorecase)
(set! smartcase)

;; Substitution
(set! gdefault)

;;; Misellaneous configuration

;; Paste mode
(set! pastetoggle "<F3>")

;; Diff mode
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; Lazy redraw
(set! lazyredraw)

;; LocalLeader
(let! maplocalleader " ")
