(module core.options
  {require-macros [core.macros]})

;;; =========================
;;; Local variable definition
;;; =========================

; Define configuration folder
(def- configuration-folder (vim.fn.stdpath :config))

;;; =========================
;;; Environment configuration
;;; =========================

; Define python binary
(let! python3_host_prog "/home/linuxbrew/.linuxbrew/bin/python3")

;;; ====================
;;; Editor configuration
;;; ====================

;; ------------------
;; File configuration
;; ------------------
; Do not write backups
(set! nobackup)
(set! nowritebackup)
; Do not create swap files
(set! noswapfile)

;; -------------------------
;; Indentation configuration
;; -------------------------
; Use spaces instead of tabs
(set! expandtab)
; More intelligent indentation
(set! smarttab)
; Number of spaces used for each <Tab> and auto-indent
(let [value 2]
  (set! tabstop value)
  (set! shiftwidth value)
  (set! softtabstop value))

;; ----------------------
;; Wrapping configuration
;; ----------------------
; Enable soft-wrapping
(set! wrap)
; Do no break words at the middle
(set! nolinebreak)
; Maintain indentation on break
(set! breakindent)
; Add characters after wrap
(set! breakindentopt ["shift:2"])
; Show character after wrap
(set! showbreak "↳ ")

;; --------------------
;; Format configuration
;; --------------------
(set! formatoptions [:q :j])

;; ----------------------------
;; Spell-checking configuration
;; ----------------------------
(set! spell)
(set! spelllang [:en])
(set! spelloptions [:camel])

;; ----------------
;; Undo persistence
;; ----------------
(set! undodir (.. configuration-folder "/undodir.nvim"))
(set! undofile)

;;; ======================
;;; Terminal configuration
;;; ======================

;; -------------
;; Mouse support
;; -------------
(set! mouse :a)

;;; ====================
;;; Visual configuration
;;; ====================

;; ----------
;; True color
;; ----------
(set! termguicolors)

;; -----------
;; Line number
;; -----------
(set! number)
(set! relativenumber)

;; -------------------
;; Search highlighting
;; -------------------
(set! nohlsearch)

;; ---------------------
;; Conceal configuration
;; ---------------------
(set! concealcursor "")

;; --------------------
;; Status configuration
;; --------------------
(set! noshowmode)

;; --------------------
;; Column configuration
;; --------------------
(set! colorcolumn [81])

;; ------------------------
;; Characters configuration
;; ------------------------
; Show whitespace characters
(set! list)
; Define characters
(set! listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; -----------
;; Sign column
;; -----------
; Always show sign column
(set! signcolumn "yes")

;; ------------------
;; Fold configuration
;; ------------------
; Start with everything unfolded
(set! foldlevelstart 99)
; Function that generates folding
(set! fillchars "fold: ")
(set! foldtext #(vim.fn.printf "   %-6d%s"
                               (- vim.v.foldend (+ vim.v.foldstart 1))
                               (vim.fn.getline vim.v.foldstart)))

;;; ========================
;;; Completion configuration
;;; ========================

;; ----------------------
;; Insert-mode completion
;; ----------------------
(set! infercase)
(set! shortmess+ :c)

;; -----------------------
;; Command-mode completion
;; -----------------------
(set! wildmenu)
(set! wildcharm 9) ; <Tab>
(set! wildignorecase)

;;; =====================
;;; Command configuration
;;; =====================

;; ------------------
;; Search and replace
;; ------------------
(set! ignorecase)
(set! smartcase)

;; ------------
;; Substitution
;; ------------
; Use g option by default
(set! gdefault)

;;; ===========================
;;; Miscellaneous configuration
;;; ===========================

;; ----------
;; Paste mode
;; ----------
; Toggle mapping
(set! pastetoggle "<F3>")

;; ---------
;; Diff-mode
;; ---------
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; ---------
;; Backspace
;; ---------
(set! backspace [:indent :eol :start])

;; -----------
;; Lazy redraw
;; -----------
(set! lazyredraw)

;; ------
;; Hidden
;; ------
(set! hidden)

;; -----------
;; LocalLeader
;; -----------
(let! maplocalleader " ")
