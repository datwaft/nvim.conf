(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)
(import-macros {: extend-fn} :themis.fn)

(fn executable? [...] (= 1 (vim.fn.executable ...)))

(fn escape [combination]
  (vim.api.nvim_replace_termcodes combination true true true))

;;; =========================
;;; Environment configuration
;;; =========================
; Define python binary
(let! python3_host_prog (if (executable? "python") (vim.fn.exepath "python")
                          (executable? "python3") (vim.fn.exepath "python3")
                          nil))
; Disable some providers
(let! loaded_ruby_provider 0)
(let! loaded_perl_provider 0)

;;; ====================
;;; Editor configuration
;;; ====================
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
(set! nospell)
(set! spelllang [:en :es])
(set! spelloptions [:camel :noplainbuffer])
(let [config-folder (vim.fn.stdpath "config")
      spell-folder (.. config-folder "/spell")]
  (set! spellfile+ (.. spell-folder "/en.utf-8.add"))
  (set! spellfile+ (.. spell-folder "/es.utf-8.add")))

;; Undo persistence
(set! undofile)

;; CursorHold delay
(set! updatetime 500)

;; External configuration file
(set! exrc)

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

;; Stabilize lines
(set! splitkeep :screen)

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
(set! signcolumn "yes:1")

;; Fold configuration
; Enable folding
(set! foldenable)
; Display column for folds
(set! foldcolumn "1")
; Fold column characters
(set! fillchars {:eob " "
                 :fold " "
                 :foldopen ""
                 :foldsep " "
                 :foldclose ""})
; Start with everything unfolded
(set! foldlevelstart 99)

;;; ========================
;;; Completion configuration
;;; ========================
;; Insert-mode completion
(set! infercase)
(set! shortmess+ :c)

;; Command-mode completion
(set! wildcharm (string.byte (escape "<tab>")))
(set! wildignorecase)

;; Support fuzzy finding
(set! path ["." "**"])

;;; ==========================
;;; Command-mode configuration
;;; ==========================
;; Search and replace
(set! ignorecase)
(set! smartcase)

;;; ===========================
;;; Miscellaneous configuration
;;; ===========================
;; Diff-mode
(set! diffopt+ "linematch:60")

;; Lazy redraw
(set! lazyredraw)

;; Timeout for mappings
(set! timeoutlen 500)

;; LocalLeader
(let! maplocalleader (escape "<space>"))

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;; NETRW
(let! netrw_silent 1)

;;; ===========================================
;;; Override configuration for floating windows
;;; ===========================================
;; Extend vim.lsp.util.open_floating_preview
(extend-fn vim.lsp.util.open_floating_preview [_ winid]
  (vim.api.nvim_win_set_option winid :breakindentopt "")
  (vim.api.nvim_win_set_option winid :showbreak "NONE"))
