(module core.options)

;;; =========================
;;; Local variable definition
;;; =========================

; Define configuration folder
(def- configuration-folder (vim.fn.stdpath :config))

;;; =========================
;;; Environment configuration
;;; =========================

; Define python binary
(set vim.g.python3_host_prog "/usr/bin/python3")

;;; ====================
;;; Editor configuration
;;; ====================

;; ------------------
;; File configuration
;; ------------------
; Do not write backups
(set vim.opt.backup false)
(set vim.opt.writebackup false)
; Do not create swap files
(set vim.opt.swapfile false)

;; -------------------------
;; Indentation configuration
;; -------------------------
; Use spaces instead of tabs
(set vim.opt.expandtab true)
; More intelligent indentation
(set vim.opt.smarttab true)
; Number of spaces used for each <Tab> and auto-indent
(let [value 2]
  (set vim.opt.tabstop value)
  (set vim.opt.shiftwidth value)
  (set vim.opt.softtabstop value))

;; ----------------------
;; Wrapping configuration
;; ----------------------
; Enable soft-wrapping
(set vim.opt.wrap true)
; Do no break words at the middle
(set vim.opt.linebreak false)
; Maintain indentation on break
(set vim.opt.breakindent true)
; Add characters after wrap
(set vim.opt.breakindentopt ["shift:2"])
; Show character after wrap
(set vim.opt.showbreak "↳ ")

;; --------------------
;; Format configuration
;; --------------------
(set vim.opt.formatoptions [:q :j])

;; ----------------------------
;; Spell-checking configuration
;; ----------------------------
(set vim.opt.spell true)
(set vim.opt.spelllang [:en])
(set vim.opt.spelloptions  [:camel])

;; ----------------
;; Undo persistence
;; ----------------
(set vim.opt.undodir (.. configuration-folder "/undodir.nvim"))
(set vim.opt.undofile true)

;;; ======================
;;; Terminal configuration
;;; ======================

;; -------------
;; Mouse support
;; -------------
(set vim.opt.mouse :a)

;;; ====================
;;; Visual configuration
;;; ====================

;; ----------
;; True color
;; ----------
(set vim.opt.termguicolors true)

;; -----------
;; Line number
;; -----------
(set vim.opt.number true)
(set vim.opt.relativenumber true)

;; -------------------
;; Search highlighting
;; -------------------
(set vim.opt.hlsearch false)

;; ---------------------
;; Conceal configuration
;; ---------------------
(set vim.opt.concealcursor "")

;; --------------------
;; Status configuration
;; --------------------
(set vim.opt.showmode false)

;; --------------------
;; Column configuration
;; --------------------
(set vim.opt.colorcolumn [81])

;; ------------------------
;; Characters configuration
;; ------------------------
; Show whitespace characters
(set vim.opt.list true)
; Define characters
(set vim.opt.listchars {:trail "·"
                        :tab "→ "
                        :nbsp "·"})

;; -----------
;; Sign column
;; -----------
; Always show sign column
(set vim.opt.signcolumn "yes")

;; ------------------
;; Fold configuration
;; ------------------
; Start with everything unfolded
(set vim.opt.foldlevelstart 99)
; Function that generates folding
(tset _G :__core_foldtext
      (fn []
        (vim.fn.printf "   %-6d%s"
                       (- vim.v.foldend (+ vim.v.foldstart 1))
                       (vim.fn.getline vim.v.foldstart))))
(set vim.opt.fillchars "fold: ")
(set vim.opt.foldtext "v:lua.__core_foldtext()")

;;; ========================
;;; Completion configuration
;;; ========================

;; ----------------------
;; Insert-mode completion
;; ----------------------
(set vim.opt.infercase true)
(: vim.opt.shortmess :append :c)

;; -----------------------
;; Command-mode completion
;; -----------------------
(set vim.opt.wildmenu true)
(set vim.opt.wildcharm 9) ; <Tab>
(set vim.opt.wildignorecase true)

;;; =====================
;;; Command configuration
;;; =====================

;; ------------------
;; Search and replace
;; ------------------
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)

;; ------------
;; Substitution
;; ------------
; Use g option by default
(set vim.opt.gdefault true)

;;; ===========================
;;; Miscellaneous configuration
;;; ===========================

;; ----------
;; Paste mode
;; ----------
; Toggle mapping
(set vim.opt.pastetoggle "<F3>")

;; ---------
;; Diff-mode
;; ---------
(set vim.opt.diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; ---------
;; Backspace
;; ---------
(set vim.opt.backspace [:indent :eol :start])

;; -----------
;; Lazy redraw
;; -----------
(set vim.opt.lazyredraw true)

;; ------
;; Hidden
;; ------
(set vim.opt.hidden true)


;; -----------
;; LocalLeader
;; -----------
(vim.cmd "let maplocalleader = \" \"")
